{ pkgs, lib, config, ... }:

let
  homelab = config.homelab;
in
{
  # Configure graphical interfaces
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    epiphany    # web browser
  ];

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      nerdfonts
      (nerdfonts.override { fonts = [ "Noto" ]; })
    ];
    enableDefaultPackages = true;
  };

  # Add variables for C-Cedilha if on homelab
  environment.variables = lib.mkIf homelab.keyboardCCedilla {
    GTK_IM_MODULE = "cedilla";
    QT_IM_MODULE = "cedilla";
  };
}
