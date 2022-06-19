# Linux Workstation Playbook

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)][pre-commit]
[![Tests](https://github.com/staticdev/linux-workstation-playbook/workflows/Tests/badge.svg)][tests]

[pre-commit]: https://github.com/pre-commit/pre-commit
[tests]: https://github.com/staticdev/linux-workstation-playbook/actions?workflow=Tests

## Features

- Development: [Python tools].
  - IDEs: [Pycharm], [VSCode] and [VSCodium] installation.
- Browsers: [Firefox] configuration and [Brave] installation.
- Packages intallation: apt, snap, pip, npm, ruby gems.
- Assorted FOSS programs: [Cryptomator], [Keypass], [OBS], [OpenRGB] or [Signal messenger] installation.
- Configurations: shell/terminals, [Gnome], [Git], ssh, keyboard and dotfiles in general.

Note: this is a setup playbook I use for personal and professional development. It currently supports for [Debian] 11 (Bullseye). Refer to release 0.1.0 for Ubuntu.

## Requirements

- [Ansible] installed: on Debian you can just run:

```sh
sudo apt install python3-pip
pip install --user ansible
```

If **~/.local/bin** is not on **echo \$PATH**, you can add it with the command:

```sh
sudo echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc && source ~/.bashrc
```

## Installation

1. [Download] and extract this playbook or clone this repository to your local drive.

```sh
git clone git@github.com:staticdev/linux-workstation-playbook.git
```

2. Install dependencies by entering the terminal in the playbook folder and run the command:

```sh
ansible-galaxy install -r requirements.yml
```

## Usage

1. Make a copy of **default.config.yml** with the name **config.yml** and change the configurations you want to use.
2. Run the command:

```sh
ansible-playbook main.yml -i inventory --ask-become-pass
```

### Overriding Defaults

Not everyone's workstation and preferred software configuration is the same.

You can override any of the defaults configured in **default.config.yml** by creating a **config.yml** file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

```yaml
installed_packages:
  - git
  - go

snap_packages:
  - name: postman

npm_packages:
  - name: webpack

pip_packages:
  - name: mkdocs
```

Any variable can be overridden in **config.yml**; see the supporting roles' documentation for a complete list of available variables.

### Use with a remote machine

You can use this playbook to manage other machine as well; the playbook doesn't even need to be run from a Linux computer at all! If you want to manage a remote Linux, either another Linux on your network, or a hosted Linux in the cloud, you just need to make sure you can connect to it with SSH.

Edit the **inventory** file in this repository and change the line that starts with **127.0.0.1** to:

```ini
[ip address or hostname of linux]  ansible_user=[linux ssh username]
```

If you need to supply an SSH password (if you don't use SSH keys), make sure to pass the **--ask-pass** parameter to the **ansible-playbook** command.

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
- guake
- htop
- locales-all
- nmap
- node
- openssl
- poedit
- thefuck
- tmux
- vagrant
- vim
- xclip
- wget
```

Finally, there are a few other preferences and settings added on for various apps and services.

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

% github-only

[@geerlingguy]: https://github.com/geerlingguy
[ansible]: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
[brave]: https://brave.com/
[contributor guide]: CONTRIBUTING.md
[cryptomator]: https://cryptomator.org/
[debian]: https://www.debian.org/
[download]: https://github.com/staticdev/linux-workstation-playbook/archive/refs/heads/main.zip
[file an issue]: https://github.com/staticdev/linux-workstation-playbook/issues
[firefox]: https://www.mozilla.org/firefox/
[git]: https://git-scm.com/
[gnome]: https://www.gnome.org/
[keypass]: https://keepass.info/
[mac development ansible playbook]: https://github.com/geerlingguy/mac-dev-playbook
[mit]: https://opensource.org/licenses/MIT
[obs]: https://obsproject.com/
[openrgb]: https://gitlab.com/CalcProgrammer1/OpenRGB
[pycharm]: https://www.jetbrains.com/pycharm/
[python tools]: https://github.com/staticdev/ansible-role-python-developer
[signal messenger]: https://signal.org
[vscode]: https://code.visualstudio.com/
[vscodium]: https://vscodium.com/
