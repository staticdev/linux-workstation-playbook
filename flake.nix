{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-24.11;
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    mainModules = [
      (import "${self}/modules")
      configuration.nix
      inputs.home-manager.nixosModules.default
    ]
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
            stateVersion = self.stateVersion;
            hostName = prop.hostName;
          };
        };

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = mainModules ++ optionalLocalModules;
    };
  };
}
