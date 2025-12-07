{
  description = "Opinionated Core Nix Configuration";

  inputs = { };

  outputs = { ... }: {
    lib = {
      mkPkgs = { system, nixpkgs-unstable, nixpkgs-stable }: {
        pkgs = import nixpkgs-unstable { inherit system; };
        pkgs-stable = import nixpkgs-stable { inherit system; };
      };
    };

    nix-darwin = ./nix-darwin;
    home-manager = ./home-manager;
  };
}
