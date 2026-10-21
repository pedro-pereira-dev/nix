{ self, inputs, ... }: {
  flake.nixosConfigurations.nixos-desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.disko.nixosModules.disko
      inputs.preservation.nixosModules.default
      ./_system/hardware-configuration.nix
      ./_system/disko.nix
      self.nixosModules.profile-base
      self.nixosModules.system-code
      self.nixosModules.profile-desktop
      self.nixosModules.system-sshd
      self.nixosModules.system-user-chuck
      ({ pkgs, ... }: {
        nixpkgs.hostPlatform = "x86_64-linux";
        networking.hostName = "nixos-desktop";

        boot.initrd.kernelModules = [ "amdgpu" ];
        services.lact.enable = true;

        services.fwupd.enable = true;

        environment.systemPackages = [
          pkgs.alacritty
          pkgs.btop
          pkgs.fastfetch
          pkgs.htop
          pkgs.radeontop
          pkgs.vulkan-tools
        ];
      })
    ];
  };
}
