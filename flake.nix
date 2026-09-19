{
  description = "Opinionated Core Nix Configuration";

  inputs = {
    mattpocock-skills = {
      url = "github:mattpocock/skills/v1.2.3";
      flake = false;
    };
    humanlayer-skills = {
      url = "github:humanlayer/skills/ca7c8088db69e315a8b2deea43820270457f8f3c";
      flake = false;
    };
    humanizer-skills = {
      url = "github:blader/humanizer/e2e92e7b4b8229253ed5c8e81dc65463fdeddda5";
      flake = false;
    };
    herdr-skills = {
      url = "github:herdrdev/herdr/v0.9.0";
      flake = false;
    };
    qmx-skills = {
      url = "github:qmx/skills/master";
      flake = false;
    };
  };

  outputs =
    {
      mattpocock-skills,
      humanlayer-skills,
      humanizer-skills,
      herdr-skills,
      qmx-skills,
      ...
    }:
    {
      nix-darwin = ./nix-darwin;

      home-manager =
        { lib, pkgs, ... }:
        {
          imports = [ ./home-manager ];

          programs.agent-skills = {
            enable = lib.mkDefault true;

            sources = {
              mattpocock = {
                src = lib.mkDefault mattpocock-skills;
                include = lib.mkDefault [
                  "skills/engineering/*"
                  "skills/productivity/*"
                ];
              };

              humanlayer = {
                src = lib.mkDefault humanlayer-skills;
                include = lib.mkDefault [
                  "plugins/show-me/skills/show-me"
                  "plugins/visual-pr/skills/visual-pr"
                ];
              };

              humanizer = {
                src = lib.mkDefault (
                  pkgs.linkFarm "humanizer-skills" [
                    {
                      name = "humanizer";
                      path = humanizer-skills;
                    }
                  ]
                );
                include = lib.mkDefault [ "humanizer" ];
              };

              herdr = {
                src = lib.mkDefault herdr-skills;
                include = lib.mkDefault [ "skills/herdr" ];
              };

              qmx = {
                src = lib.mkDefault qmx-skills;
                include = lib.mkDefault [ "herdr-worktree" ];
              };
            };
          };
        };
    };
}
