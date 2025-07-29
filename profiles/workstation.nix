{ config, pkgs, ... }:

{
  boot = {
    plymouth = {
      enable = true;
    };
  };
  imports = [
    ../modules/desktop.nix
    ../modules/print.nix
    ../modules/audio.nix
    ../modules/apps.nix
    ../modules/libvirt.nix
  ];
}
