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
