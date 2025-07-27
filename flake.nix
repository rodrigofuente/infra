{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {self, nixpkgs, nixos-hardware, ... }: let
      hardwareConfigs = {
        "argo" = {
          system   = "x86_64-linux";
          hardware = "thinkpad";
          profile  = "workstation";
        };
        "prydwen" = {
          system   = "x86_64-linux";
          hardware = "nuc";
          profile  = "workstation";
        };
        "selene" = {
          system   = "x86_64-linux";
          hardware = "mac";
          profile  = "workstation";
        };
      };

      mkSystem = hostname: hardwareConfigs: nixpkgs.lib.nixosSystem {
        system = hardwareConfigs.system;
        specialArgs = {
          inherit nixpkgs nixos-hardware;
          inherit hostname;
        };
        modules = [
          modules/common.nix
          hosts/${hostname}.nix
          hardware/${hardwareConfigs.hardware}.nix
          profiles/${hardwareConfigs.profile}.nix
        ];
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem hardwareConfigs;
  };
}
