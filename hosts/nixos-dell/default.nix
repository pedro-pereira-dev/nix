{ self, inputs, ... }: {
  flake.nixosConfigurations.nixos-dell = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.default
      ./_system/hardware-configuration.nix
      ./_system/disko.nix
      self.nixosModules.profile-base
      self.nixosModules.system-code
      self.nixosModules.profile-desktop
      self.nixosModules.system-bluetooth
      self.nixosModules.system-sshd
      inputs.home-manager.nixosModules.home-manager
      self.nixosModules.system-user-chuck
      ({ ... }: {
        nixpkgs.hostPlatform = "x86_64-linux";
        networking.hostName = "nixos-dell";

        services.fwupd.enable = true;
      })
    ];
  };
}
