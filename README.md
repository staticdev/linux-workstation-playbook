# Linux Workstation Playbook

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)][pre-commit]
[![Tests](https://github.com/staticdev/linux-workstation-playbook/workflows/Tests/badge.svg)][tests]

[pre-commit]: https://github.com/pre-commit/pre-commit
[tests]: https://github.com/staticdev/linux-workstation-playbook/actions?workflow=Tests

## Features

- Development: [Golang], [NodeJs] and [Python tools].
  - IDEs: [VSCodium] and [Pycharm] installation.
- Browsers: [Firefox] ESR replacement with official PPA and configuration; and [Brave] installation.
- Package manager installation: [Nix] and [Home Manager].
- Packages intallation: apt, nix, snap, npm and ruby gems.
  - Note: pip packages are enforced to not be installed globally on Debian 12 by [PEP-668].
- Replaces [LibreOffice] with [OnlyOffice].
- Assorted FOSS programs: [Cryptomator], [KeyPass], [OBS], [OpenRGB], [RClone], and [Signal] messenger installation.
- Configurations: dotfiles, shell/terminals, [Gnome], [Git], ssh, keyboard...

Note: this is an opinionated setup I personally use for software development on [Debian] 12. You can customize all the changes following instructions in [Overriding Defaults](#overriding-defaults).

## Requirements

1. [Ansible] installed:

   ```sh
   sudo apt install ansible-core
   ```

   If you get an error saying no installation candidate, edit your apt sources files with:

   ```sh
   sudo gedit /etc/apt/sources.list
   ```

   Remove DVD repos (if you see them) and make sure you have:

   ```sh
   deb http://deb.debian.org/debian/ bookworm main contrib non-free-firmware
   deb-src http://deb.debian.org/debian/ bookworm main contrib non-free-firmware

   deb http://security.debian.org/debian-security bookworm-security main contrib non-free-firmware
   deb-src http://security.debian.org/debian-security bookworm-security main contrib non-free-firmware

   # bookworm-updates, to get updates before a point release is made;
   # see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
   deb http://deb.debian.org/debian/ bookworm-updates main contrib non-free-firmware
   deb-src http://deb.debian.org/debian/ bookworm-updates main contrib non-free-firmware
   ```

   1. If **~/.local/bin** is not on **echo \$PATH**, you can add it with the command:

   ```sh
   sudo echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc && source ~/.bashrc
   ```

## Installation

1. [Download] and extract this playbook or clone this repository to your local drive.

   ```sh
   git clone git@github.com:staticdev/linux-workstation-playbook.git
   ```

1. Install dependencies by entering the terminal in the playbook folder and run the command:

   ```sh
   ansible-galaxy install -fr requirements.yml
   ```

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

For [Nix] packages, it is necessary to specify a command that will verify if it is already installed, most binaries support `--version` or just `version`, eg:

```yaml
nix_packages:
  - name: git
    check_cmd: git --version
  - name: kubectl
    check_cmd: kubectl version --client
```

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

To have you own dotfiles, just fork the [dotfiles eg. repo] and change the url of `dotfiles_repo` or just change `configure_dotfiles` to false if you do not want it.

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
[ansible]: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
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
[nix]: https://nixos.org/
[obs]: https://obsproject.com/
[onlyoffice]: https://github.com/ONLYOFFICE/
[openrgb]: https://gitlab.com/CalcProgrammer1/OpenRGB
[pep-668]: https://peps.python.org/pep-0668/
[pycharm]: https://www.jetbrains.com/pycharm/
[python tools]: https://github.com/staticdev/ansible-role-python-developer
[rclone]: https://rclone.org/
[signal]: https://signal.org
[vscodium]: https://vscodium.com/
