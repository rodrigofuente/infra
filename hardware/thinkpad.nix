{ config, pkgs, hostname, ... }:

{

  # WIP: specific Thinkpad support
  services.fprintd.enable = true;

  services.openssh.enable = true;
  system.stateVersion = "25.05";
}
