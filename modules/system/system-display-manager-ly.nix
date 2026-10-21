{ ... }: {
  flake.nixosModules.system-display-manager-ly = { ... }: {
    services.displayManager.ly.enable = true;
  };
}
