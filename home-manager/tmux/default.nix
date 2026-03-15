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
      
      # Explicitly bind Shift+Enter to send CSI-u sequence
      # This is required because tmux only forwards extended keys to panes
      # that request them via Kitty activation sequence, which pi doesn't send
      bind-key -n S-Enter send-keys "\e[13;2u"
      
      set -g status-left '[#S] #h '
      set -g status-left-length 20
    '';
  };
}
