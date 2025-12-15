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
    "Bash(nix flake check:*)"
    "Bash(nix log:*)"
    "Bash(nix search:*)"
    "Bash(nix show-derivation:*)"
  ];

  generalCommands = [
    "Bash(find:*)"
    "WebSearch"
  ];

  beadsMcpCommands = [
    "mcp__beads__set_context"
    "mcp__beads__show"
    "mcp__beads__update"
    "mcp__beads__stats"
    "mcp__beads__ready"
    "mcp__beads__list"
    "mcp__beads__close"
  ];
in
{
  programs.claude-code = {
    enable = true;
    settings = {
      includeCoAuthoredBy = false;
      alwaysThinkingEnabled = true;
      permissions = {
        auto-approve = generalCommands ++ gitCommands ++ nixCommands ++ beadsMcpCommands;
      };
      hooks = {
        PreCompact = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "bd prime";
              }
            ];
          }
        ];
        SessionStart = [
          {
            matcher = "";
            hooks = [
              {
                type = "command";
                command = "bd prime";
              }
            ];
          }
        ];
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
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
