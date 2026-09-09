{
  description = "Opinionated Core Nix Configuration";

  inputs = {
    mattpocock-skills = {
      url = "github:mattpocock/skills/v1.2.3";
      flake = false;
    };
    humanlayer-skills = {
      url = "github:humanlayer/skills/3c2629142c5d437428269b1b722b08c0b87f574d";
      flake = false;
    };
    humanizer-skills = {
      url = "github:blader/humanizer/e2e92e7b4b8229253ed5c8e81dc65463fdeddda5";
      flake = false;
    };
  };

  outputs =
    {
      mattpocock-skills,
      humanlayer-skills,
      humanizer-skills,
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
                include = lib.mkDefault [ "plugins/show-me/skills/show-me" ];
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
            };
          };
        };
    };
}
