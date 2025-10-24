{ ... }:
{
  programs.git = {
    enable = true;

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
