{ inputs, ... }:
{
  imports = [ inputs.preservation.nixosModules.default ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  preservation = {
    enable = true;
    preserveAt."/persistent" = {
      directories = [{ directory = "/var/lib/nixos"; inInitrd = true; } "/var/lib/systemd/timers" "/var/log"];
      files = [{ file = "/etc/machine-id"; inInitrd = true; }];
    };
  };

  console.keyMap = "pt-latin9";
  time.timeZone = "Europe/Lisbon";

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 4;
  boot.loader.efi.canTouchEfiVariables = true;
}
