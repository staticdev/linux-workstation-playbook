{ pkgs, ... }:
let
  fontFamily = "NotoMono Nerd Font Mono";
  fontSize = 15;
  shell = "${pkgs.tmux}/bin/tmux";
in
{
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
      font = "${fontFamily} ${toString fontSize}";
      customCommand = shell;
    };
  };
}
