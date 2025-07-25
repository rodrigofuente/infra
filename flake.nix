{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {self, nixpkgs, nixos-hardware, ... }: let
      hardwareConfigs = {
        "aegis" = {
          system = "x86_64-linux";
          type   = "mac";
        };
        "freedom" = {
          system = "x86_64-linux";
          type   = "nuc";
        };
      };

      mkSystem = hostname: config: nixpkgs.lib.nixosSystem {
        system = config.system;
        specialArgs = {
          inherit nixpkgs nixos-hardware;
          inherit hostname;
        };
        modules = [
          ./common.nix
          ./hardware-configuration-${hostname}.nix
          ./configuration-${config.type}.nix
        ];
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem hardwareConfigs;
  };
}

# gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
