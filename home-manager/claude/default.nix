{ pkgs, lib, ... }:
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
    "Bash(nix log:*)"
    "Bash(nix search:*)"
    "Bash(nix show-derivation:*)"
  ];

  generalCommands = [
    "Bash(find:*)"
    "WebSearch"
  ];
in
{
  programs.claude-code = {
    enable = true;
    settings = {
      includeCoAuthoredBy = false;
      alwaysThinkingEnabled = true;
      permissions = {
        auto-approve = generalCommands ++ gitCommands ++ nixCommands;
      };
    } // lib.optionalAttrs pkgs.stdenv.isDarwin {
      hooks = {
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

  programs.git.ignores = [
    "CLAUDE.local.md"
  ];
}
