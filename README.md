# Linux Workstation Playbook

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)][pre-commit]
[![Tests](https://github.com/staticdev/linux-workstation-playbook/workflows/Tests/badge.svg)][tests]

[pre-commit]: https://github.com/pre-commit/pre-commit
[tests]: https://github.com/staticdev/linux-workstation-playbook/actions?workflow=Tests

## Features

- Support processor architectures: x86_64 (only one for now, may be extended in the future).
- IDEs: [VSCodium] installation (via Nixpkgs), [Neovim] (via [NixVim]).
- Browsers: [Brave] and [Mullvad Browser] (via Nix).
- Containers and virtualization: [Docker], [Podman] and [libvirtd].
- Your favorite programs via [Nixpkgs].
- Configurations: dotfiles, [tmux] and zsh (via Nix), Guake terminal, [Gnome] (and extensions), [Git], ssh, keyboard...

Note: this is an opinionated setup I personally use for software development on [NixOS](https://nixos.org). You can customize all the changes following instructions in [Overriding Defaults](#overriding-defaults).

## Requirements

1. Install latest stable, recommended Minimal ISO image from [NixOS download ISO page](https://nixos.org/download/#nixos-iso).
1. [Ansible] installed. Make sure you have it in you `local.nix` either in `systemWidePkgs` or `mainUser.pkgs`.

## Installation

1. Create a `local.nix` file from [eg folder](eg/local.nix) and change:
  - git variables.
  - main Linux username.
  - timezone.
  - browser configurations.
1. Create at /etc/nixos a `flake.nix` file [eg folder](eg/flake.nix).

   ```sh
   curl -s "https://raw.githubusercontent.com/staticdev/linux-workstation-playbook/main/eg/flake.nix?token=$(date +%s)" -o /etc/nixos/flake.nix
   nixos-generate-config
   nixos-rebuild boot --upgrade-all
   ```

1. Rebuild hardware config with `sudo nixos-generate-config`.
1. Rebuild your system with `sudo nixos-rebuild boot --upgrade-all`.

## Usage

1. Make a copy of **default.config.yml** with the name **config.yml** and change the configurations you want to use.
1. Run the command:

   ```sh
   ansible-playbook main.yml -i inventory --ask-become-pass
   ```

### Included Applications / Configuration (Default)

It installs packages with [Nix] package manager:

```yaml
- git
- thefuck
- tmux
- wget
- wl-clipboard
```

Finally, there are a few other preferences and settings added on for various apps and services.

Dotfiles for [tmux] and [zsh] are already configured in specific modules.

### Overriding Defaults

Not everyone's workstation and preferred software configuration is the same.

You can override any of the defaults configured in **default.config.yml** by creating a **config.yml** file and setting the overrides in that file.

For [Nix] packages, update your [Home Manager] config on your dotfiles repo.

Any variable can be overridden in **config.yml**; see the supporting roles' documentation for a complete list of available variables.

### Use with a remote machine

You can use this playbook to manage other machine as well; the playbook doesn't even need to be run from a Linux computer at all! If you want to manage a remote Linux, either another Linux on your network, or a hosted Linux in the cloud, you just need to make sure you can connect to it with SSH.

Edit the **inventory** file in this repository and change the line that starts with **127.0.0.1** to:

```ini
[ip address or hostname of linux]  ansible_user=[linux ssh username]
```

If you need to supply an SSH password (if you don't use SSH keys), make sure to pass the **--ask-pass** parameter to the **ansible-playbook** command.

## Contributing

Contributions are very welcome.
To learn more, see the [Contributor Guide].

## License

Distributed under the terms of the [MIT] license,
_Linux Workstation Playbook_ is free and open source software.

## Issues

If you encounter any problems,
please [file an issue] along with a detailed description.

## Credits

This project was inspired by [@geerlingguy]'s [Mac Development Ansible Playbook].

[@geerlingguy]: https://github.com/geerlingguy
[brave]: https://brave.com/
[contributor guide]: https://github.com/staticdev/linux-workstation-playbook/blob/main/CONTRIBUTING.md
[debian]: https://www.debian.org/
[docker]: https://www.docker.com/
[download]: https://github.com/staticdev/linux-workstation-playbook/archive/refs/heads/main.zip
[file an issue]: https://github.com/staticdev/linux-workstation-playbook/issues
[git]: https://git-scm.com/
[nixpkgs]: https://search.nixos.org/packages
[gnome]: https://www.gnome.org/
[home manager]: https://github.com/nix-community/home-manager
[libvirtd]: https://libvirt.org/manpages/libvirtd.html
[mac development ansible playbook]: https://github.com/geerlingguy/mac-dev-playbook
[mit]: https://opensource.org/licenses/MIT
[mullvad browser]: https://mullvad.net/en/browser
[neovim]: https://github.com/neovim/neovim
[nix]: https://nixos.org/
[nixos download iso page]: https://nixos.org/download/#nixos-iso
[nixvim]: https://github.com/nix-community/nixvim
[pep-668]: https://peps.python.org/pep-0668/
[podman]: https://podman.io/
[tmux]: https://github.com/tmux/tmux
[vscodium]: https://vscodium.com/
[zsh]: https://www.zsh.org/
