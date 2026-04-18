{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs.direnv;
    nix-direnv.enable = true;
  };
}
