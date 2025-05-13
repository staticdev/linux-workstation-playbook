{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  { self, ... }@inputs:
  let
    stateVersion = "24.11";
  in
  {
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
          stateVersion = stateVersion;
          hostName = prop.hostName;
        };
        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.nixvim.nixosModules.nixvim
          (import "${self}/pkgs/overlays.nix" { inherit inputs; })
          (import "${self}/modules")
          (import "${self}/src")
          (import "${self}/src/base.nix")
          (import "${self}/modules/gui")
        ]
        ++ prop.modules;
      };
    };
  };
}
