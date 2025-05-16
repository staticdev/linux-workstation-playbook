{ lib, homelab, ... }:

{
  home.packages = homelab.dconf.gnomeExtensions;
  dconf.settings = lib.mkMerge [
    {
      "org/gnome/shell" = lib.mkMerge [
        # Gnome extensions
        {

          disable-user-extensions = false;
          enabled-extensions = lib.lists.forEach homelab.dconf.gnomeExtensions (e: e.extensionUuid);
        }
        # Favorite apps for Dash
        (lib.mkIf (homelab.dconf.favoriteApps != [ ]) {
          favorite-apps = homelab.dconf.favoriteApps;
        })
      ];
    }
    # Guake keybinding
    (lib.mkIf (homelab.dconf.guakeHotkey != null) {
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/guake/" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/guake" = {
        name = "Guake";
        command = "/usr/bin/guake-toggle";
        binding = homelab.dconf.guakeHotkey;
      };
    })
    # Hot corners
    {
      "org/gnome/desktop/interface".enable-hot-corners = homelab.dconf.hotCorners;
    }
    # Keyboard layout
    {
      "org/gnome/desktop/input-sources".sources =
        map (k:
        lib.hm.gvariant.mkTuple [
          "xkb" (k.layout + (if k.variant != null then "+" + k.variant else ""))
          ]
        ) homelab.dconf.keyboardLayout;
    }
    # Show lock-screen notifications
    {
      "org/gnome/desktop/notifications".show-in-lock-screen = homelab.dconf.lockScreenNotifications;
    }
    # Night light
    (lib.mkIf homelab.dconf.nightLight {
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = 2700;
        night-light-schedule-automatic = false;
        night-light-schedule-to = 6.0;
        night-light-schedule-from = 16.0;
        night-light-last-coordinates = "(91.0, 181.0)";
        active = true;
        priority = 0;
      };
    })
  ];
}
