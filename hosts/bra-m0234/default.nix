{ inputs, ... }: {
  flake.darwinConfigurations.bra-m0234 = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      inputs.home-manager.darwinModules.home-manager
      ({ pkgs, ... }: {
        nixpkgs.hostPlatform = "aarch64-darwin";
        networking.hostName = "bra-m0234";
        system.primaryUser = "pereiped";
        system.stateVersion = 6;
        security.pam.services.sudo_local.touchIdAuth = true;

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        users.users.pereiped.home = "/Users/pereiped";
        environment.systemPackages = [
          pkgs.fastfetch
        ];

        homebrew = {
          enable = true;
          taps = [ "deskflow/tap" ];
          casks = [
            "deskflow/tap/deskflow"
            "librewolf"
          ];
        };

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.pereiped = {
            home.stateVersion = "25.05";
            home.file.".librewolf/librewolf.overrides.cfg".text = ''
              pref("browser.tabs.inTitlebar", 0);
            '';
          };
        };
      })
    ];
  };
}
