{ self, ... }: {
  flake.nixosModules.profile-desktop = { ... }: {
    imports = [
      self.nixosModules.system-display-manager-ly
      self.nixosModules.system-librewolf
      self.nixosModules.system-window-manager-labwc
    ];
  };
}
