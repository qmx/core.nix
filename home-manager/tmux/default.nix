{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    terminal = "xterm-kitty";
    extraConfig = ''
      # Enable Kitty keyboard protocol passthrough
      set -g extended-keys on
      set -g extended-keys-format csi-u
      set -g allow-passthrough on
      
      # Enable terminal features for Kitty keyboard protocol
      set -ga terminal-features ',xterm*:extkeys+@kitty-keyboard'
      set -ga terminal-features ',kitty*:extkeys+@kitty-keyboard'
      
      # Pass through terminal capabilities
      set -ga terminal-overrides ',xterm-256color*:Tc'
      set -ga terminal-overrides ',kitty*:Tc'
      
      set -g status-left '[#S] #h '
      set -g status-left-length 20
    '';
  };
}
