{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/preservation-rollback.nix
    ../../profiles/shared.nix
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  networking.hostName = "nixos-dell";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  hardware.bluetooth.enable = true;
  hardware.enableRedistributableFirmware = true;

  preservation.preserveAt."/persistent".directories = [
    "/etc/NetworkManager/system-connections"
    "/var/lib/NetworkManager"
    "/var/lib/iwd"
    "/var/lib/bluetooth"
  ];

  services.logind.enable = true;
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.logind.settings.Login.HandlePowerKey = "poweroff";

  services.openssh.enable = true;
  services.openssh.hostKeys = [{ path = "/persistent/etc/ssh/ssh_host_ed25519_key"; type = "ed25519"; }];
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";

  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  users.users.root.hashedPassword = "!";

  services.getty.autologinUser = "chuck";
  users.users.chuck.extraGroups = [ "wheel" ];
  users.users.chuck.hashedPasswordFile = "/persistent/secrets/chuck";
  users.users.chuck.isNormalUser = true;
  users.users.chuck.openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbHkOpoucRSqD/zKiyC2xtjw0F/JeUtZlrmMuLy2iWd" ];

  programs.labwc.enable = true;
  programs.bash.loginShellInit = ''[ "$(tty)" = /dev/tty1 ] && exec labwc'';

  environment.systemPackages = [
    pkgs.alacritty
    pkgs.btop
    pkgs.fastfetch
    pkgs.htop
    pkgs.neovim
  ];
}
