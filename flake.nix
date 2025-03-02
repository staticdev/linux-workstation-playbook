{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  { self, ... }@inputs:
  {
    stateVersion = "24.11";
    optionalLocalModules =
      nix_paths:
      builtins.concatLists (
        inputs.nixpkgs.lib.lists.forEach nix_paths (
          path: inputs.nixpkgs.lib.optional (builtins.pathExists path) (import path)
        )
      );
    systemTypes = {
      x86_64 = prop: {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          hostName = prop.hostName;
        };
        modules = [
          ./configuration.nix
          ./modules/sysconf.nix
          inputs.home-manager.nixosModules.default
          (import "${self}/pkgs/overlays.nix" { inherit inputs; })
        ]
        ++ prop.modules;
      };
    };
  };
}
