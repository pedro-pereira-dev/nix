{ ... }: {
  flake.nixosModules.system-locale = { ... }: {
    console.keyMap = "pt-latin9";
    time.timeZone = "Europe/Lisbon";
  };
}
