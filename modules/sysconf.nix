{ lib, pkgs, ... }:
{
  options.environment.sysConf = {
    git = lib.mkOption {
      type = with lib.types; attrsOf str;
      default = {
        userName = "Rick Sanchez";
        email = "Rick.Sanchez@Wabalaba.dubdub";
      };
      description = "The git configs for commits: userName and email";
    };

    keyboardCCedilla = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable cedilla support via GTK/QT IM modules.";
    };
    keyboardLayout = lib.mkOption {
      type = with lib.types; listOf (submodule {
        options = {
          layout = lib.mkOption {
            type = str;
            description = "Keyboard layout, e.g. 'us'";
            example = "us";
          };

          variant = lib.mkOption {
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

    mainUser = lib.mkOption {
      type = with lib.types; attrsOf (oneOf [str (listOf package)]);
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

    systemWidePkgs = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = with pkgs; [
            openssl
        ];
        description = "The system packages";
    };

    timeZone = lib.mkOption {
      type = lib.types.str;
      default = "UTC";
      description = "The system time zone";
    };
  };

  config = { };
}
