{ pkgs, pkgs-unstable, lib, ... }:
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
    package = pkgs-unstable.claude-code;
    settings = {
      includeCoAuthoredBy = false;
      alwaysThinkingEnabled = true;
      permissions = {
        auto-approve = generalCommands ++ gitCommands ++ nixCommands ++ beadsCommands ++ tmuxCommands;
        deny = [
          "Bash(nix develop:*)"
        ];
      };
      hooks = {
        PreToolUse = [
          {
            matcher = "Bash";
            hooks = [
              {
                type = "command";
                command = "${pkgs.jq}/bin/jq -e '.tool_input.command | test(\"git.*push|push.*git\")' > /dev/null && { echo 'Git push blocked. Ask user to push manually.' >&2; exit 2; }; exit 0";
              }
            ];
          }
        ];
      } // lib.optionalAttrs pkgs.stdenv.isDarwin {
        Notification = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "${pkgs.jq}/bin/jq -r '.message' | xargs -I {} /usr/bin/osascript -e 'display notification \"{}\" with title \"Claude\" sound name \"Sosumi\"'";
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

  programs.git.ignores = [
    "CLAUDE.local.md"
  ];
}
