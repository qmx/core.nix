{ ... }:
{
  xdg.configFile."ghostty/config".text = builtins.readFile ./config;
}
