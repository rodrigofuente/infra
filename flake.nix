{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  inputs = {
    vmtools.url = "github:4km3/vmtools";
    vmtools.flake = false;
  };

  outputs = {self, nixpkgs, nixos-hardware, ... }: let
      hardwareConfigs = {
        "aegis" = {
	  system = "x86_64-linux";
	  hardwareModules = [
	    ./hardware-configuration-aegis.nix
	  ];
	};
        "freedom" = {
	  system = "x86_64-linux";
	  hardwareModules = [
	    ./hardware-configuration-freedom.nix
	  ];
	};
      };

      commonModules = [
        ./configuration.nix
      ];
    
      mkSystem = hostname: config: nixpkgs.lib.nixosSystem {
        system = config.system;
        specialArgs = {
          inherit nixpkgs nixos-hardware;
	  inherit hostname;
        };
        modules = commonModules ++ config.hardwareModules ++ [
          {
	    networking.hostName = hostname;
	    nixpkgs.hostPlatform = config.system;
	  }
        ];
      };
    in {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkSystem hardwareConfigs;
  };
}
