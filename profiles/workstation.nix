{ config, ... }:

{
  imports = [
    ../modules/desktop.nix
    ../modules/print.nix
    ../modules/audio.nix
    ../modules/apps.nix
    ../modules/libvirt.nix
  ];
}
