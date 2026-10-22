{ self, ... }: {
  flake.nixosModules.system-user-chuck = { ... }: {
    imports = [ self.nixosModules.system-user-root ];

    users.users.chuck.isNormalUser = true;
    users.users.chuck.extraGroups = [ "wheel" ];
    nix.settings.trusted-users = [ "chuck" ];

    users.users.chuck.hashedPasswordFile = "/persistent/secrets/chuck";
    users.users.chuck.initialPassword = "changeme";

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.chuck = { pkgs, ... }: {
        home.username = "chuck";
        home.homeDirectory = "/home/chuck";
        home.stateVersion = "26.11";

        home.packages = [
          pkgs.alacritty
          pkgs.nerd-fonts.code-new-roman
        ];

        programs.bash.enable = true;

        home.file = {
          ".bashrc".force = true;
          ".bash_profile".force = true;
        };

        xdg.configFile."alacritty/alacritty.toml" = {
          source = ../home/chuck/alacritty.toml;
          force = true;
        };
      };
    };

    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = "chuck";
    services.displayManager.defaultSession = "labwc";
    services.displayManager.ly.x11Support = false;

    users.users.chuck.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbHkOpoucRSqD/zKiyC2xtjw0F/JeUtZlrmMuLy2iWd"
    ];
  };
}
