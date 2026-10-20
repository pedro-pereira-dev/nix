{ ... }: {
  flake.nixosModules.system-user-root = { ... }: {
    users.users.root.hashedPassword = "!";
  };
}
