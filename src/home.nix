{ lib, stateVersion, sysConf, ... }:

# here we have system-wide configuration - for user configurations see: src/users.nix
{
  imports = [ (import ./dconf.nix { inherit lib sysConf; }) ];

  home = {
    stateVersion = stateVersion;
  };

  programs.git = {
    enable = true;
  };

  programs.gnome-terminal = {
    enable = true;
    themeVariant = "dark";
    showMenubar = false;
    profile."352f48f0-7279-422e-9e0a-95228e86bd1d" = {
      visibleName = "default";
      default = true;
      allowBold = true;
      audibleBell = false;
      showScrollbar = false;
      cursorShape = "block";
      cursorBlinkMode = "off";
      font = "NotoMono Nerd Font Mono 15";
      customCommand = "tmux";
    };
  };
}
