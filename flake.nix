{
  description = "Opinionated Core Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { nixpkgs, nixpkgs-stable, ... }: {
    lib = {
      mkPkgs = system: {
        pkgs = import nixpkgs { inherit system; };
        pkgs-stable = import nixpkgs-stable { inherit system; };
      };
    };

    nix-darwin = ./nix-darwin;
    home-manager = ./home-manager;
  };
}
