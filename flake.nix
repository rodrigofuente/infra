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
