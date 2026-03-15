{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    terminal = "tmux-256color";
    extraConfig = ''
      # Enable Kitty keyboard protocol passthrough
      set -g extended-keys on
      set -g extended-keys-format csi-u
      set -g allow-passthrough on
      
      # Pass through terminal features from outer terminal
      set -ga terminal-overrides ',xterm-256color*:Tc'
      set -ga terminal-overrides ',screen-256color*:Tc'
      set -ga terminal-overrides ',tmux-256color*:Tc'
      
      set -g status-left '[#S] #h '
      set -g status-left-length 20
    '';
  };
}
