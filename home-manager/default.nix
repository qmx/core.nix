{ ... }:
{
  imports = [
    ./claude
    ./direnv
    ./gh
    ./ghostty
    ./git
    ./gnupg
    ./jq
    ./neovim
    ./opencode
    ./starship
    ./tmux
    ./zsh
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.home-manager.enable = true;
}
