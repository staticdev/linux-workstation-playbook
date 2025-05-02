{ lib, pkgs, ... }:

let
  inherit (lib) mkOption types;
in {
  options.environment.sysConf = {
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

    mainUser = mkOption {
      type = with types; attrsOf (oneOf [str (listOf package)]);
      default = {
        name = "rick";
        pkgs = with pkgs; [
          git
          tmux
          vscodium
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
}
