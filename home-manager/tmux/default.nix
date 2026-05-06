{ pkgs, ... }:

let
  tmuxHostStatusStyle = pkgs.writeShellScript "tmux-host-status-style" ''
    idx=$(hostname | cksum | cut -d " " -f1)

    # 16 fixed xterm-256 backgrounds. Each entry also pins the
    # foreground to fixed black/white so contrast survives light/dark themes.
    case "$((idx % 16))" in
      0) style="bg=colour17,fg=colour231" ;;  # navy / white
      1) style="bg=colour22,fg=colour231" ;;  # green / white
      2) style="bg=colour52,fg=colour231" ;;  # maroon / white
      3) style="bg=colour53,fg=colour231" ;;  # purple / white
      4) style="bg=colour23,fg=colour231" ;;  # teal / white
      5) style="bg=colour54,fg=colour231" ;;  # indigo / white
      6) style="bg=colour88,fg=colour231" ;;  # red / white
      7) style="bg=colour90,fg=colour231" ;;  # magenta / white
      8) style="bg=colour39,fg=colour16" ;;   # sky blue / black
      9) style="bg=colour46,fg=colour16" ;;   # lime / black
      10) style="bg=colour51,fg=colour16" ;;  # cyan / black
      11) style="bg=colour82,fg=colour16" ;;  # spring green / black
      12) style="bg=colour118,fg=colour16" ;; # chartreuse / black
      13) style="bg=colour154,fg=colour16" ;; # yellow-green / black
      14) style="bg=colour208,fg=colour16" ;; # orange / black
      15) style="bg=colour220,fg=colour16" ;; # gold / black
    esac

    tmux set -g status-style "$style"
  '';
in
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

      # Deterministic host-dependent status bar color (16 high-contrast options)
      run-shell '${tmuxHostStatusStyle}'

      set -g status-left '[#S] #h '
      set -g status-left-length 20
    '';
  };
}
