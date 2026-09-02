{ ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    settings = {
      alias = {
        graph = "log --oneline --graph --all";
      };
      init = {
        defaultBranch = "master";
      };
      core = {
        editor = "nvim";
      };
    };
  };
}
