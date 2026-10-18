{ ... }: {
  flake.nixosModules.base = { config, pkgs, ... }: {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    console.keyMap = "pt-latin9";
    time.timeZone = "Europe/Lisbon";

    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 4;
    boot.loader.efi.canTouchEfiVariables = true;

    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    preservation = {
      enable = true;
      preserveAt."/persistent" = {
        directories = [
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
          "/var/lib/systemd/timers"
          "/var/log"
        ];
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];
      };
    };

    boot.initrd.systemd.enable = true;
    boot.initrd.systemd.services.preservation-rollback = {
      after = [ "initrd-root-device.target" ];
      before = [ "sysroot.mount" ];
      wantedBy = [ "initrd.target" ];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      path = with pkgs; [
        btrfs-progs
        util-linux
      ];
      script = ''
        mount --mkdir -o subvol=/ ${config.fileSystems."/".device} /rollback
        btrfs subvolume delete --recursive /rollback/root
        btrfs subvolume create /rollback/root
        umount /rollback
      '';
    };

  };
}
