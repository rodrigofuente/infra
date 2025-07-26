{ config, pkgs, hostname,... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter]
    experimental-features = ['scale-monitor-framebuffer']
  '';
  services.xserver.libinput.touchpad.disableWhileTyping = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  networking.networkmanager.enable = true;

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    neovim
    zed-editor
    git
    go-task
  ];

  services.openssh.enable = true;
  system.stateVersion = "25.05";
}
