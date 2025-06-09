{ config, lib, pkgs, ... }:

let
  hl = config.homelab;
  cfg = hl.nfs;
in
{
  options.homelab.nfs = {
    enable = lib.mkEnableOption {
      description = "Enable declarative NFS mounts for the homelab";
    };

    mounts = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          remoteHost = lib.mkOption {
            type = lib.types.str;
            description = "Remote NFS server hostname or IP";
          };

          remotePath = lib.mkOption {
            type = lib.types.str;
            description = "Path on the remote server to mount";
          };

          localPath = lib.mkOption {
            type = lib.types.str;
            description = "Path where the NFS share will be mounted locally";
          };

          options = lib.mkOption {
            type = lib.types.str;
            default = "defaults";
            description = "Mount options for the NFS mount";
          };

          fsType = lib.mkOption {
            type = lib.types.enum [ "nfs" "nfs4" ];
            default = "nfs4";
            description = "NFS version to use (nfs or nfs4)";
          };
        };
      });

      default = { };
      description = "List of NFS shares to mount on this machine";
      example = {
        backups = {
          remoteHost = "nas.local";
          remotePath = "/exports/backups";
          localPath = "/mnt/backups";
          options = "noatime";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    # Ensure required directories exist
    systemd.tmpfiles.rules = map
      (m: "d ${m.localPath} 0755 root root - -")
      (lib.attrValues cfg.mounts);

    # Mount NFS shares via fileSystems
    fileSystems = lib.mapAttrs' (name: m: {
      name = m.localPath;
      value = {
        device = "${m.remoteHost}:${m.remotePath}";
        fsType = m.fsType;
        options = [ m.options ];
      };
    }) cfg.mounts;

    # Optionally allow NFS client ports through firewall if needed
    networking.firewall.allowedTCPPorts = lib.mkDefault [ 2049 ];
    networking.firewall.allowedUDPPorts = lib.mkDefault [ 2049 ];
  };
}
