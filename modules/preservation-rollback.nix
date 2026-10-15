{ config, pkgs, ... }:
{
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.services.preservation-rollback = {
    after = [ "initrd-root-device.target" ];
    before = [ "sysroot.mount" ];
    wantedBy = [ "initrd.target" ];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ btrfs-progs util-linux ];
    script = ''
      mount --mkdir -o subvol=/ ${config.fileSystems."/".device} /rollback
      btrfs subvolume delete --recursive /rollback/root
      btrfs subvolume create /rollback/root
      umount /rollback
    '';
  };
}
