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
    ghostty
    mpv
    libimobiledevice
    ifuse
    ollama
  ];

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  services.protonmail-bridge.enable = true;
}
