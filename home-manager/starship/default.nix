{ pkgs-stable, ... }:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    package = pkgs-stable.starship;
  };
}
