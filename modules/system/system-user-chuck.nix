{ self, ... }: {
  flake.nixosModules.system-user-chuck = { ... }: {
    imports = [ self.nixosModules.system-user-root ];

    users.users.chuck.isNormalUser = true;
    users.users.chuck.extraGroups = [ "wheel" ];
    nix.settings.trusted-users = [ "chuck" ];

    users.users.chuck.hashedPasswordFile = "/persistent/secrets/chuck";
    users.users.chuck.initialPassword = "changeme";

    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "chuck";
    services.displayManager.defaultSession = "labwc";
    services.displayManager.ly.x11Support = false;

    users.users.chuck.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbHkOpoucRSqD/zKiyC2xtjw0F/JeUtZlrmMuLy2iWd"
    ];
  };
}
