{ lib, ... }:
{
  options.homelab.services = {
    enable = lib.mkEnableOption "Settings and services for the homelab";
  };
  imports = [
    ./deluge
    ./jellyfin
    ./wireguard-netns
  ];
}
