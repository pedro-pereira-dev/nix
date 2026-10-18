# nix

## User passwords

Root is wiped every boot, so password hashes live in `/persistent/secrets/$_user` and are referenced with `users.users.<user>.hashedPasswordFile`.
Create one per user, as root on the machine, before applying the config:

    _user=<user>
    mkdir -p /persistent/secrets && chmod 700 /persistent/secrets
    mkpasswd -m yescrypt > /persistent/secrets/$_user
    chmod 600 /persistent/secrets/$_user

## Layout

Dendritic pattern: flake-parts + import-tree. Every `.nix` file under `modules/` and `hosts/` is a flake-parts module, except files prefixed with `_`.

- `modules/` shared features, published as `flake.modules.nixos.<name>`.
- `hosts/<name>/default.nix` defines `flake.nixosConfigurations.<name>` and lists its features explicitly. Plain NixOS files for that host (`_disko.nix`, `_hardware-configuration.nix`) are imported by path.

To add a host, create `hosts/<name>/default.nix`; no other file needs editing.

nix --extra-experimental-features "nix-command flakes" run nixpkgs#nixos-rebuild -- switch \
  --flake path:.#nixos-dell \
  --target-host chuck@192.168.1.193 \
  --build-host chuck@192.168.1.193 \
  --sudo \
  --ask-sudo-password
