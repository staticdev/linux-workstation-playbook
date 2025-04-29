{ lib, sysConf, stateVersion, ... }:

# here we have system-wide configuration - for user configurations see: src/users.nix
{
  dconf.settings."org/gnome/desktop/input-sources".sources =
    map (k:
     lib.hm.gvariant.mkTuple [
      "xkb" (k.layout + (if k.variant != null then "+" + k.variant else "")) 
      ]
    ) sysConf.keyboardLayout;

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
