{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {self, nixpkgs, nixos-hardware, ... }: let
      hardwareConfigs = {
        "argo" = {
          system   = "x86_64-linux";
          profile  = "workstation";
          extraModules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-p14s-amd-gen2
            (
              { config, ... }:
              {
                services.fprintd.enable = true;
              }
            )
          ];
        };
        "prydwen" = {
          system   = "x86_64-linux";
          profile  = "workstation";
          extraModules = [ nixos-hardware.nixosModules.intel-nuc-8i7beh];
        };
        "selene" = {
          system   = "x86_64-linux";
          profile  = "workstation";
          extraModules = [ nixos-hardware.nixosModules.apple-macbook-pro-14-1 ];
        };
      };

      mkSystem = hostname: hardwareConfig: nixpkgs.lib.nixosSystem {
        system = hardwareConfig.system;
        specialArgs = {
          inherit nixpkgs nixos-hardware;
          inherit hostname;
        };
        modules = [
          modules/common.nix
          hosts/${hostname}.nix
          profiles/${hardwareConfig.profile}.nix
        ] ++ hardwareConfig.extraModules;
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem hardwareConfigs;
  };
}
