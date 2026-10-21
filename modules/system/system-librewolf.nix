{ ... }: {
  flake.nixosModules.system-librewolf = { pkgs, ... }: {
    environment.systemPackages = [
      (pkgs.librewolf.override {
        extraPrefsFiles = pkgs.librewolf-unwrapped.extraPrefsFiles ++ [
          (pkgs.writeText "librewolf-system-titlebar.js" ''
            pref("browser.tabs.inTitlebar", 0);
          '')
        ];
        extraPolicies.ExtensionSettings."uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      })
    ];
  };
}
