{ config, pkgs, ... }:

{
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
    zed-editor
    git
    go-task
  ];
}
