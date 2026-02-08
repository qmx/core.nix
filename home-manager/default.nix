{ ... }:
{
  imports = [
    ./btop
    ./direnv
    ./gh
    ./ghostty
    ./git
    ./gnupg
    ./jq
    ./neovim
    ./starship
    ./tmux
    ./zsh
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.home-manager.enable = true;
}
