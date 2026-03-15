{ config, pkgs, ... }:
{
  # Ghostty on macOS reads from ~/Library/Application Support/com.mitchellh.ghostty/config
  # On Linux it reads from ~/.config/ghostty/config
  # We write to the appropriate location based on the platform
  home.file = let
    isDarwin = pkgs.stdenv.isDarwin;
    configPath = if isDarwin
      then "Library/Application Support/com.mitchellh.ghostty/config"
      else ".config/ghostty/config";
  in {
    "${configPath}".text = builtins.readFile ./config;
  };
}
