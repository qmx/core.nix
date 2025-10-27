{ ... }:
{
  imports = [
    ./direnv
    ./gh
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
