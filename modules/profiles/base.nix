{ self, ... }: {
  flake.nixosModules.profile-base = { ... }: {
    imports = [
      self.nixosModules.system-bootloader
      self.nixosModules.system-locale
      self.nixosModules.system-preservation
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
