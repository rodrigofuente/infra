{ config, pkgs, hostname, ... }:

{

  # WIP: specific NUC support

  services.openssh.enable = true;
  system.stateVersion = "25.05";
}
