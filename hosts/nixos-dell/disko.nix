{ inputs, ... }:
{
  imports = [ inputs.disko.nixosModules.disko ];

  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persistent".neededForBoot = true;

  disko.devices.disk.main = {
    device = "/dev/nvme0n1";
    type = "disk";

    content.type = "gpt";

    content.partitions.esp = {
      name = "ESP";
      size = "1G";
      type = "EF00";

      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
        mountOptions = [ "umask=0077" ];
        extraArgs = [ "-n" "BOOT" ];
      };
    };

    content.partitions.swap = {
      name = "SWAP";
      size = "4G";

      content = {
        type = "swap";
        extraArgs = [ "-L" "SWAP" ];
        resumeDevice = true;
      };
    };

    content.partitions.root = {
      name = "ROOT";
      size = "100%";

      content = {
        type = "btrfs";
        extraArgs = [ "-f" "-L" "NIX" ];
        subvolumes = {

          "/nix" = {
            mountOptions = [ "compress=lzo" "noatime" ];
            mountpoint = "/nix";
          };

          "/persistent" = {
            mountOptions = [ "compress=lzo" "noatime" ];
            mountpoint = "/persistent";
          };

          "/root" = {
            mountOptions = [ "compress=lzo" "noatime" ];
            mountpoint = "/";
          };

        };
      };
    };
  };
}
