{
  description = "nixos";

  inputs = { 
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }:
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          extraSpecialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [ ./configuration.nix inputs.home-manager.nixosModules.home-manager ];
        };
      };
    };
}

