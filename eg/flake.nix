{
  inputs = {
    cfg = {
      url = "github:staticdev/linux-workstation-playbook";
    };
  };

  outputs =
    { cfg, ... }:
    let
      mkHost =
        host: systemType:
        systemType {
          hostName = host;
          modules = [
            ./hardware-configuration.nix
            ./local.nix
          ];
        };
    in
    {
      nixosConfigurations = builtins.mapAttrs mkHost {
        nixos = cfg.systemTypes.x86_64;
      };
    };
}
