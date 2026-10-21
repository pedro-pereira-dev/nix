{ ... }: {
  flake.nixosModules.system-code = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      neovim
      git
      lazygit
      tmux
      opencode
      pi-coding-agent
    ];
  };
}
