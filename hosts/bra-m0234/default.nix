{ inputs, ... }: {
  flake.darwinConfigurations.bra-m0234 = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      inputs.home-manager.darwinModules.home-manager
      ({ pkgs, ... }: {
        nixpkgs.hostPlatform = "aarch64-darwin";
        networking.hostName = "bra-m0234";
        system.primaryUser = "pereiped";
        system.stateVersion = 6;

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
          casks = [ "deskflow/tap/deskflow" ];
        };

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.pereiped.home.stateVersion = "25.05";
        };
      })
    ];
  };
}
