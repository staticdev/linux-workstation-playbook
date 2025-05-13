{ pkgs, lib, config, ... }:

{
  imports = [
    ./gnome.nix
    ./xdg.nix
  ];
}
