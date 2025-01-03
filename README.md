# Linux Workstation Playbook

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)][pre-commit]
[![Tests](https://github.com/staticdev/linux-workstation-playbook/workflows/Tests/badge.svg)][tests]

[pre-commit]: https://github.com/pre-commit/pre-commit
[tests]: https://github.com/staticdev/linux-workstation-playbook/actions?workflow=Tests

## Features

- Support processor architectures: x86_64 (only one for now, may be extended in the future).
- Development: [Golang], [NodeJs] and [Python tools].
  - IDEs: [VSCodium] and [Pycharm] installation.
- Browsers: [Brave], [Firefox] and [Mullvad Browser].
- Replaces [LibreOffice] with [OnlyOffice].
- Assorted FOSS programs: [Cryptomator], [KeyPass], [OBS], [OpenRGB], [RClone], and [Signal] messenger installation.
- Configurations: dotfiles, shell/terminals, [Gnome], [Git], ssh, keyboard...

Note: this is an opinionated setup I personally use for software development on [NixOS](https://nixos.org). You can customize all the changes following instructions in [Overriding Defaults](#overriding-defaults).

## Requirements

1. Install latest stable, recommended Minimal ISO image from [NixOS download ISO page](https://nixos.org/download/#nixos-iso).

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

Packages (installed with apt):

```yaml
- apache2-utils
- cmake
- dconf-editor # visual gnome configs
- gir1.2-clutter-1.0 # dep gnome extension system monitor
- gir1.2-clutter-gst-3.0 # dep gnome extension system monitor
- gir1.2-gtkclutter-1.0 # dep gnome extension system monitor
- git
- locales-all
- openssl
- podman
- poedit
```

It also installs with [Nix] package manager:

```yaml
- kubectl
- helm
- k9s
- htop
- libvirt
- nmap
- qemu
- thefuck
- tmux
- vagrant
- vim
- wget
- xclip
```

Finally, there are a few other preferences and settings added on for various apps and services.

### Overriding Defaults

Not everyone's workstation and preferred software configuration is the same.

You can override any of the defaults configured in **default.config.yml** by creating a **config.yml** file and setting the overrides in that file.

The first thing one can customize is the list of installed packages with apt (Debian's package manager):

```yaml
installed_packages:
  - go
```

To have you own dotfiles, just fork the [dotfiles eg. repo] and change the url of `dotfiles_repo` or just change `configure_dotfiles` to false if you do not want it.

For [Nix] packages, update your [Home Manager] config on your dotfiles repo.

Other package managers:

```yaml
# requires snapd
snap_packages:
  - name: code
    classic: true
  - name: postman

npm_packages:
  - name: webpack
```

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
[cryptomator]: https://cryptomator.org/
[debian]: https://www.debian.org/
[dotfiles eg. repo]: https://github.com/staticdev/dotfiles-eg
[download]: https://github.com/staticdev/linux-workstation-playbook/archive/refs/heads/main.zip
[file an issue]: https://github.com/staticdev/linux-workstation-playbook/issues
[firefox]: https://www.mozilla.org/firefox/
[git]: https://git-scm.com/
[gnome]: https://www.gnome.org/
[golang]: https://go.dev/
[home manager]: https://github.com/nix-community/home-manager
[libreoffice]: https://www.libreoffice.org/
[nodejs]: https://nodejs.org/
[keypass]: https://keepass.info/
[mac development ansible playbook]: https://github.com/geerlingguy/mac-dev-playbook
[mit]: https://opensource.org/licenses/MIT
[mullvad browser]: https://mullvad.net/en/browser
[nix]: https://nixos.org/
[nixos download iso page]: https://nixos.org/download/#nixos-iso
[obs]: https://obsproject.com/
[onlyoffice]: https://github.com/ONLYOFFICE/
[openrgb]: https://gitlab.com/CalcProgrammer1/OpenRGB
[pep-668]: https://peps.python.org/pep-0668/
[pycharm]: https://www.jetbrains.com/pycharm/
[python tools]: https://github.com/staticdev/ansible-role-python-developer
[rclone]: https://rclone.org/
[signal]: https://signal.org
[vscodium]: https://vscodium.com/
