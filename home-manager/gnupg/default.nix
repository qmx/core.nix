{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnupg
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableZshIntegration = true;
    defaultCacheTtl = 1800;
    maxCacheTtl = 7200;
    pinentry.package = pkgs.pinentry_mac;
    grabKeyboardAndMouse = false;
    extraConfig = ''
      # Clean configuration without problematic options
    '';
  };
}
