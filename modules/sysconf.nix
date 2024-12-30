{ lib, pkgs, ... }:
{
  options.environment.sysConf = {
    gitUserName = lib.mkOption {
      type = lib.types.str;
      default = "Rick Sanchez";
      description = "The name to use for git commits";
    };

    gitEmail = lib.mkOption {
      type = lib.types.str;
      default = "Rick.Sanchez@Wabalaba.dubdub";
      description = "The email to use for git commits";
    };

    mainUser = lib.mkOption {
      type = lib.types.str;
      default = "rick";
      description = "The main user of the system";
    };

    mainUserPkgs = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = with pkgs; [
          git
          tmux
          vscodium
        ];
        description = "The main user packages";
    };

    systemWidePkgs = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = with pkgs; [
            vim
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
