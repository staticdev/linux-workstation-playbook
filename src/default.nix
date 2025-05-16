{ config, stateVersion, ... }:

let
  homelab = config.homelab;
in
{
  system = {
    stateVersion = stateVersion;
  };

  home-manager = {
    sharedModules = [ (import ./home.nix) ];
    extraSpecialArgs = {
      inherit stateVersion;
      inherit homelab;
    };
  };
}
