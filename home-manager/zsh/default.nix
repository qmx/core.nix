{ config, ... }:
{
  programs.zsh = {
    enable = true;

    history = {
      size = 50000;
      save = 50000;
      path = "${config.home.homeDirectory}/.zhistory";
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    initContent = builtins.readFile ./init.zsh;
  };
}
