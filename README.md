# nixfiles

## Usage

`nix` is required to run `./nixfiles`

Operation, one of:
* `--activate` - switches a installed system to a configuration
* `--install` - installs nixos using nixos-anywhere configuration, wiping a defined disk

System, one of:
* `--self` - configures the machine executing the script
* `--target <user@host>` - configures a system reachable by ssh

Not required:
* `--host <name>` - chooses which configuration to apply, prompts a selection if omitted

```bash
./nixfiles --activate --self
```

```bash
./nixfiles --activate --target user@192.168.1.99
```

```bash
./nixfiles --install --self
```

```bash
./nixfiles --install --target user@192.168.1.99
```

Using remote repository:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/pedro-pereira-dev/nixfiles/main/nixfiles)" --activate --self
```

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/pedro-pereira-dev/nixfiles/main/nixfiles)" --activate --target user@192.168.1.99
```

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/pedro-pereira-dev/nixfiles/main/nixfiles)" --install --self
```

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/pedro-pereira-dev/nixfiles/main/nixfiles)" --install --target user@192.168.1.99
```

## User passwords

Root is wiped every boot, so password hashes live in `/persistent/secrets/$_user` and are referenced with `users.users.<user>.hashedPasswordFile`.
Create one per user, as root on the machine, before applying the config:

    _user=<user>
    mkdir -p /persistent/secrets && chmod 700 /persistent/secrets
    mkpasswd -m yescrypt > /persistent/secrets/$_user
    chmod 600 /persistent/secrets/$_user
