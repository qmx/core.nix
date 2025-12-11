{
  description = "Opinionated Core Nix Configuration";

  inputs = { };

  outputs = { ... }: {
    nix-darwin = ./nix-darwin;
    home-manager = ./home-manager;
  };
}
