# nix

## User passwords

Root is wiped every boot, so password hashes live in `/persistent/secrets/$_user` and are referenced with `users.users.<user>.hashedPasswordFile`.
Create one per user, as root on the machine, before applying the config:

    _user=<user>
    mkdir -p /persistent/secrets && chmod 700 /persistent/secrets
    mkpasswd -m yescrypt > /persistent/secrets/$_user
    chmod 600 /persistent/secrets/$_user
