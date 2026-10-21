{ self, inputs, ... }: {
  flake.nixosConfigurations.nixos-dell = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.default
      ./_system/hardware-configuration.nix
      ./_system/disko.nix
      self.nixosModules.profile-base
      self.nixosModules.profile-desktop
      self.nixosModules.system-bluetooth
      self.nixosModules.system-sshd
      self.nixosModules.system-user-chuck
      ({ pkgs, ... }: {
        nixpkgs.hostPlatform = "x86_64-linux";
        networking.hostName = "nixos-dell";

        services.fwupd.enable = true;

        environment.systemPackages = [
          pkgs.alacritty
        ];
      })
    ];
  };
}
