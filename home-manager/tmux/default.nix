{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    extraConfig = ''
      set -g allow-passthrough on
      set -g status-left '[#S] #h '
      set -g status-left-length 20
    '';
  };
}
