{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    terminal = "screen-256color";
    extraConfig = ''
      # Enable extended keys support
      set -g extended-keys on
      set -g extended-keys-format csi-u
      set -g allow-passthrough on
      
      # Tell tmux that Ghostty (xterm-kitty) supports extended keys and OSC 8 hyperlinks
      set -g terminal-features ',xterm-kitty:extkeys,hyperlinks'
      
      set -g status-left '[#S] #h '
      set -g status-left-length 20
    '';
  };
}
