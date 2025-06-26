{
  description = "nixos";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, hyprland, hyprland-plugins, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          inherit system;
          modules =
            [ ./configuration.nix inputs.home-manager.nixosModules.default ];
        };
      };
      homeConfigurations = {
        nixos = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            {
              wayland.windowManager.hyprland = {
                enable = true;
                package =
                  inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
              };
            }
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
