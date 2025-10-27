{ pkgs, lib, ... }:
{
  programs.claude-code = {
    enable = true;
    settings = {
      includeCoAuthoredBy = false;
      alwaysThinkingEnabled = true;
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
