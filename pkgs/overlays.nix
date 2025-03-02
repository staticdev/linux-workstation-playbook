{ inputs, ... }:
let
  pkgs-unstable = _: prev: {
    pkgs-unstable = import (inputs.nixpkgs-unstable) {
      inherit (prev.stdenv) system;
    };
  };
in
{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nixpkgs = {
    overlays = [
      pkgs-unstable
    ];
  };
}
