{
  inputs = {
    cfg = {
      url = "github:staticdev/linux-workstation-playbook/feature/install-packages-with-home-manager";
    };
  };

  outputs =
    { cfg, ... }:
    {
      nixosConfigurations = {
        nixos = cfg.inputs.nixpkgs.lib.nixosSystem (
          cfg.systemTypes.x86_64 {
            # replace the hostname here
            hostName = "nixos";
            modules = cfg.optionalLocalModules [
              ./hardware-configuration.nix
              ./local.nix
            ];
          }
        );
      };
    };
}
