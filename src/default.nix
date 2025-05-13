{ config, stateVersion, ... }:

let
  sysConf = config.environment.sysConf;
in
{
  system = {
    stateVersion = stateVersion;
  };

  home-manager = {
    sharedModules = [ (import ./home.nix) ];
    extraSpecialArgs = {
      inherit stateVersion;
      inherit sysConf;
    };
  };
}
