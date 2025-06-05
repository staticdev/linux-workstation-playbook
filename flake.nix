{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... }@inputs:
    with inputs;
    let
      stateVersion = "25.05";

      # Modules
      defaultModules = [
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
        (import "${self}/pkgs/overlays.nix" inputs)
        (import "${self}/modules")
        (import "${self}/src")
        (import "${self}/src/base.nix")
        (import "${self}/modules/gui")
      ];
      optionalLocalModules =
        nix_paths:
        builtins.concatLists (
          inputs.nixpkgs.lib.lists.forEach nix_paths (
            path: inputs.nixpkgs.lib.optional (builtins.pathExists path) (import path)
          )
        );
    in
    {
      systemArch = {
        amd = "x86_64-linux";
      };
      systemTypes = {
        x86_64 =
          attrs:
          nixpkgs.lib.nixosSystem {
            system = self.systemArch.amd;
            specialArgs = {
              inherit stateVersion;
              inherit (attrs) hostName;
            };
            modules = [
              (import "${self}/machines/nixos.nix")
            ]
            ++ defaultModules
            ++ optionalLocalModules attrs.modules;
          };
      };
    };
}
