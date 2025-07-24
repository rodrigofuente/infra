{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  inputs = {
    vmtools.url = "github:4km3/vmtools";
    vmtools.flake = false;
  };

  outputs = {self, ...} @ inputs: {
    nixosConfigurations = {
      aegis = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          hostname = "aegis";
        };
        modules = [
          ./configuration.nix
          ./hardware-configuration-aegis.nix
        ];
      };
      freedom = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          hostname = "freedom";
        };
        modules = [
          ./configuration.nix
          ./hardware-configuration-freedom.nix
        ];
      };
    };

  };
}
