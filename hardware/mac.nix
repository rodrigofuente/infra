{ config, pkgs, hostname, ... }:

{

  # WIP: specific Mac support

  services.openssh.enable = false;
  system.stateVersion = "25.05";
}
