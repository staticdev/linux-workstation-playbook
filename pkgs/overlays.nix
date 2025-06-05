{ nixpkgs, nixpkgs-unstable, ... }:
let
  pkgs-unstable = _: prev: {
    pkgs-unstable = import nixpkgs-unstable {
      inherit (prev.stdenv) system;
    };
  };
in
{
  nix.nixPath = [ "nixpkgs=${nixpkgs}" ];
  nixpkgs = {
    overlays = [
      pkgs-unstable
    ];
  };
}
