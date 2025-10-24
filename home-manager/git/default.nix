{ ... }:
{
  programs.git = {
    enable = true;

    aliases = {
      graph = "log --oneline --graph --all";
    };

    extraConfig = {
      init = {
        defaultBranch = "master";
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
