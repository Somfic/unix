{
    description = "nixos";

    inputs = {
        nixpkgs.url = "nixpkhs/nixos-23.05";
    };

    outputs = { self, nixpkgs, ... }:
    let lib = nixpkgs.lib;
    in {
        nixosConfigurations = {
            nixos = lib.nixosSystem {
                system = "x86_64-linux";
                modules = [ ./configuration.nix ];
            };
        };
    };
}