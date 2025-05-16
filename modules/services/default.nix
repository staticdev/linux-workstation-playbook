{ lib, ... }:
{
  options.environment.sysConf.services = {
    enable = lib.mkEnableOption "Settings and services for the homelab";
  };
  imports = [
    ./deluge
    ./jellyfin
    ./wireguard-netns
  ];
}
