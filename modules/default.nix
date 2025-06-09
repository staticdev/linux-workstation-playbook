{ lib, pkgs, ... }:

let
  inherit (lib) mkOption types;
in {
  options.homelab = {
    dconf = mkOption {
      type = with types; submodule {
        options = {
          favoriteApps = mkOption {
            type = with types; listOf str;
            default = [ ];
            description = "List of favorite applications shown in GNOME Dash.";
            example = [ "brave-browser.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Terminal.desktop" ];
          };
          gnomeExtensions = mkOption {
            type = listOf package;
            default = [];
            description = "List of Gnome extensions.";
          };
          guakeHotkey = mkOption {
            type = types.nullOr str;
            default = null;
            example = "F12";
            description = "Optional hotkey for toggling Guake.";
          };
          hotCorners = mkOption {
            type = bool;
            default = false;
            description = "Whether to enable hot corners on Gnome.";
          };
          keyboardLayout = mkOption {
            type = with types; listOf (submodule {
              options = {
                layout = mkOption {
                  type = str;
                  description = "Keyboard layout, e.g. 'us'";
                  example = "us";
                };

                variant = mkOption {
                  type = nullOr str;
                  default = null;
                  description = "Optional keyboard variant, e.g. 'intl'";
                  example = "intl";
                };
              };
            });
            default = [];
            description = "List of keyboard layout and optional variant tuples.";
            example = [
              { layout = "us"; variant = "intl"; }
              { layout = "de"; variant = null; }
            ];
          };
          lockScreenNotifications = mkOption {
            type = bool;
            default = false;
            description = "Whether to enable notifications in lock screen Gnome.";
          };
          nightLight = mkOption {
            type = bool;
            default = false;
            description = "Whether to enable night light on Gnome.";
          };
        };
      };
      default = {};
      example = {
        favoriteApps = [ "brave-browser.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Terminal.desktop" ];
        gnomeExtensions = with pkgs.gnomeExtensions; [
          appindicator
          tiling-assistant
          vitals
        ];
        guakeHotkey = "F12";
        hotCorners = false;
        keyboardLayout = [
          { layout = "us"; variant = "intl"; }
          { layout = "de"; variant = null; }
        ];
        lockScreenNotifications = false;
        nightLight = true;
      };
      description = "DConf configuration for Gnome.";
    };

    git = mkOption {
      type = with types; submodule {
        options = {
          userName = mkOption {
            type = str;
            default = "Rick Sanchez";
            description = "Git global username.";
          };

          email = mkOption {
            type = str;
            default = "Rick.Sanchez@Wabalaba.dubdub";
            description = "Git global email.";
          };

          defaultBranch = mkOption {
            type = str;
            default = "main";
            description = "Default Git branch name (e.g. main or master).";
          };

          createWorkspaces = mkOption {
            type = bool;
            default = false;
            description = "Whether to enable per-workspace Git configs.";
          };

          workspaces = mkOption {
            type = listOf (submodule {
              options = {
                folderName = mkOption {
                  type = str;
                  description = "Relative folder path for the Git workspace.";
                };
                email = mkOption {
                  type = str;
                  description = "Git email to use in this workspace.";
                };
                userName = mkOption {
                  type = str;
                  description = "Git username to use in this workspace.";
                };
              };
            });
            default = [ ];
            description = "List of Git workspace configurations.";
          };
        };
      };
      default = {};
      example = {
        userName = "Rick Sanchez";
        email = "Rick.Sanchez@Wabalaba.dubdub";
        defaultBranch = "main";
        createWorkspaces = true;
        workspaces = [
          {
            folderName = "workspace_personal";
            email = "personal@example.com";
            userName = "Rick Personal";
          }
          {
            folderName = "workspace_work";
            email = "rick@rick.com";
            userName = "Rick Professional";
          }
        ];
      };
      description = "Git configuration including user info and optional workspace-specific overrides.";
    };

    keyboardCCedilla = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable cedilla support via GTK/QT IM modules.";
    };

    mainUser = mkOption {
      type = with types; attrsOf (oneOf [str (listOf package)]);
      default = {
        name = "rick";
        group = "rick";
        pkgs = with pkgs; [
          git
          thefuck
          tmux
          vscodium
          wl-clipboard
        ];
      };
      description = "The main user of the system: name and pkgs";
    };

    systemWidePkgs = mkOption {
        type = types.listOf types.package;
        default = with pkgs; [
            openssl
        ];
        description = "The system packages";
    };

    timeZone = mkOption {
      type = types.str;
      default = "UTC";
      description = "The system time zone";
    };
  };

  config = { };

  imports = [
    ./nfs
    ./services
    ./tmux.nix
  ];
}
