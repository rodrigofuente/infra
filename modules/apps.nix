{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    zed-editor
    git
    go-task
    librewolf
    ungoogled-chromium
    telegram-desktop
  ];
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
}
