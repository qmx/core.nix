{ pkgs, lib, beadsSkill, ... }:
let
  gitCommands = [
    "Bash(git ls-tree:*)"
    "Bash(git rev-parse:*)"
    "Bash(git log:*)"
    "Bash(git show:*)"
    "Bash(git status:*)"
    "Bash(git diff:*)"
    "Bash(git reflog:*)"
    "Bash(git describe:*)"
    "Bash(git ls-files:*)"
    "Bash(git cat-file:*)"
    "Bash(git rev-list:*)"
    "Bash(git show-ref:*)"
    "Bash(git for-each-ref:*)"
    "Bash(git symbolic-ref:*)"
    "Bash(git ls-remote:*)"
  ];

  nixCommands = [
    "Bash(nix build:*)"
    "Bash(nix flake check:*)"
    "Bash(nix log:*)"
    "Bash(nix search:*)"
    "Bash(nix show-derivation:*)"
  ];

  generalCommands = [
    "Bash(find:*)"
    "Bash(grep:*)"
    "WebSearch"
  ];

  beadsCommands = [
    "Bash(bd create:*)"
    "Bash(bd close:*)"
    "Bash(bd ready:*)"
    "Bash(bd list:*)"
    "Bash(bd show:*)"
    "Bash(bd update:*)"
    "Bash(bd dep:*)"
    "Bash(bd blocked:*)"
    "Bash(bd sync:*)"
    "Bash(bd stats:*)"
    "Bash(bd doctor:*)"
  ];

  tmuxCommands = [
    "Bash(tmux capture-pane:*)"
    "Bash(tmux list-panes:*)"
  ];
in
{
  home.packages = with pkgs; [
    coreutils  # Required for du in /commit command
  ];

  programs.claude-code = {
    enable = true;
    settings = {
      includeCoAuthoredBy = false;
      alwaysThinkingEnabled = true;
      permissions = {
        auto-approve = generalCommands ++ gitCommands ++ nixCommands ++ beadsCommands ++ tmuxCommands;
      };
      hooks = lib.optionalAttrs pkgs.stdenv.isDarwin {
        Notification = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "jq -r '.message' | xargs -I {} /usr/bin/osascript -e 'display notification \"{}\" with title \"Claude\" sound name \"Sosumi\"'";
              }
            ];
          }
        ];
      };
    };
    commands = {
      commit = builtins.readFile ./commands/commit.md;
    };
  };

  # Use home.file directly since programs.claude-code.skills requires a path type,
  # but flake inputs coerce to strings
  home.file.".claude/skills/beads" = {
    source = beadsSkill;
    recursive = true;
  };

  programs.git.ignores = [
    "CLAUDE.local.md"
  ];
}
