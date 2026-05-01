{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    terminal = "screen-256color";
    historyLimit = 10000;
    focusEvents = true;
    escapeTime = 0;
    extraConfig = ''
      # System clipboard via OSC 52 (Ghostty, WezTerm, Kitty, iTerm2, Alacritty)
      set -g set-clipboard on

      # Extended keys support
      set -g extended-keys on
      set -g extended-keys-format csi-u
      set -g allow-passthrough on

      # Terminal features: extkeys, hyperlinks, sync, usstyle, overline
      set -as terminal-features 'xterm-256color:extkeys,hyperlinks'
      set -as terminal-features ',xterm-kitty:extkeys,hyperlinks'
      set -as terminal-features ',tmux-256color:extkeys,hyperlinks,sync,usstyle,overline'

      set -g status-left '[#S] #h '
      set -g status-left-length 20
    '';
  };
}
