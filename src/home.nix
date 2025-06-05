{ lib, stateVersion, homelab, pkgs, ... }@attrs:

# here we have system-wide configuration - for user configurations see: src/users.nix
{
  imports = [
    (import ./dconf.nix attrs)
    (import ./terminal.nix attrs)
  ];

  home = {
    stateVersion = stateVersion;
  };

  programs.git = {
    enable = true;
  };
}
