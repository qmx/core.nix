{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.programs.agent-skills;

  selectorType = lib.types.addCheck lib.types.str validSelector;

  sourceType = lib.types.submodule {
    options = {
      src = lib.mkOption {
        type = lib.types.path;
        description = "Pinned source tree containing agent skills.";
      };

      include = lib.mkOption {
        type = lib.types.listOf selectorType;
        description = ''
          Relative skill-directory selectors to install. A selector may use
          `*` as a complete path component to match one directory level.
        '';
        example = [
          "skills/engineering/*"
          "skills/in-progress/one-skill"
        ];
      };

      exclude = lib.mkOption {
        type = lib.types.listOf selectorType;
        default = [ ];
        description = ''
          Relative skill-directory selectors removed from the included set.
          Exact paths are preferred when resolving known name collisions.
        '';
      };
    };
  };

  validSelectorComponent =
    component: component == "*" || builtins.match "[A-Za-z0-9][A-Za-z0-9._+@-]*" component != null;

  validSelector =
    selector:
    selector != ""
    && !lib.hasPrefix "/" selector
    && lib.all validSelectorComponent (lib.splitString "/" selector);

  validTarget =
    target:
    target != ""
    && !lib.hasPrefix "/" target
    && lib.all (component: component != "" && component != "." && component != "..") (
      lib.splitString "/" target
    );

  excludeMatches =
    source: selector:
    let
      glob = "${lib.escapeShellArg (toString source.src)}/${selector}";
    in
    ''
      for excludedDir in ${glob}; do
        if [ -d "$excludedDir" ] && [ -f "$excludedDir/SKILL.md" ]; then
          excludedDirs["$excludedDir"]=1
        fi
      done
    '';

  includeMatches =
    sourceName: source: selector:
    let
      glob = "${lib.escapeShellArg (toString source.src)}/${selector}";
    in
    ''
      matched=0
      for skillDir in ${glob}; do
        if [ ! -d "$skillDir" ] || [ ! -f "$skillDir/SKILL.md" ]; then
          continue
        fi

        matched=1
        if [[ -n "''${excludedDirs["$skillDir"]+present}" ]]; then
          continue
        fi

        skillName="''${skillDir##*/}"
        currentOrigin=${lib.escapeShellArg sourceName}":$skillDir"

        if [[ -n "''${skillDirs["$skillName"]+present}" ]]; then
          if [ "''${skillDirs["$skillName"]}" = "$skillDir" ]; then
            continue
          fi

          printf "agent-skills: duplicate skill name '%s'\n" "$skillName" >&2
          printf "  first:  %s\n" "''${skillOrigins["$skillName"]}" >&2
          printf "  second: %s\n" "$currentOrigin" >&2
          exit 1
        fi

        skillDirs["$skillName"]="$skillDir"
        skillOrigins["$skillName"]="$currentOrigin"
        ln -s "$skillDir" "$out/$skillName"
      done

      if [ "$matched" -eq 0 ]; then
        printf "agent-skills: selector matched no skills in '%s': %s\n" \
          ${lib.escapeShellArg sourceName} ${lib.escapeShellArg selector} >&2
        exit 1
      fi
    '';

  assembleSource = sourceName: source: ''
    unset excludedDirs
    declare -A excludedDirs=()
    ${lib.concatMapStringsSep "\n" (excludeMatches source) source.exclude}
    ${lib.concatMapStringsSep "\n" (includeMatches sourceName source) source.include}
  '';

  assembledSkills = pkgs.runCommand "agent-skills" { } ''
    mkdir -p "$out"
    shopt -s nullglob
    declare -A skillDirs=()
    declare -A skillOrigins=()
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList assembleSource cfg.sources)}
  '';
in
{
  options.programs.agent-skills = {
    enable = lib.mkEnableOption "declaratively managed agent skills";

    sources = lib.mkOption {
      type = lib.types.attrsOf sourceType;
      default = { };
      description = "Pinned source trees and selectors used to assemble the installed skill set.";
    };

    target = lib.mkOption {
      type = lib.types.str;
      default = ".agents/skills";
      description = "Home-relative directory where the assembled skills are linked.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.sources != { };
        message = "programs.agent-skills.sources must contain at least one source.";
      }
      {
        assertion = lib.all (source: source.include != [ ]) (lib.attrValues cfg.sources);
        message = "Every programs.agent-skills source must contain at least one include selector.";
      }
      {
        assertion = lib.all (source: lib.all validSelector (source.include ++ source.exclude)) (
          lib.attrValues cfg.sources
        );
        message = ''
          programs.agent-skills selectors must be relative paths containing
          ordinary path components or `*` as a complete path component.
        '';
      }
      {
        assertion = validTarget cfg.target;
        message = "programs.agent-skills.target must be a non-empty home-relative path.";
      }
    ];

    home.file."${cfg.target}" = {
      source = assembledSkills;
      recursive = true;
    };
  };
}
