==================
Linux Dev Playbook
==================

|pre-commit| |Tests|

.. |pre-commit| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
   :target: https://github.com/pre-commit/pre-commit
   :alt: pre-commit
.. |Tests| image:: https://github.com/staticdev/linux-developer-playbook/workflows/Tests/badge.svg
   :target: https://github.com/staticdev/linux-developer-playbook/actions?workflow=Tests
   :alt: Tests

Features
========

* Installations:
    * IDEs.
    * `Google Chrome`_ Browser.
    * Packages apt, pip, npm, ruby gems.
    * Assorted FOSS programs such as Cryptomator_, Keypass_, OBS_, OpenRGB_ or `Signal messenger`_
* Configurations: shell/terminals, Firefox_, Gnome_, Git_, ssh, keyboard and more.

Note: this is a setup playbook I use for personal and professional development. It currently supports for Debian_ 11 (Bullseye). Refer to release 0.1.0 for Ubuntu.


Requirements
============

* Ansible_ installed: on Debian you can just run:

.. code:: console

   sudo apt install python3-pip
   pip install --user ansible

If **~/.local/bin** is not on **echo $PATH**, you can add it with the command:

.. code:: console
   
    sudo echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc && source ~/.bashrc


Installation
============

1. Download_ and extract this playbook or clone this repository to your local drive.

.. code:: console

   git clone git@github.com:staticdev/linux-developer-playbook.git

2. Install dependencies by entering the terminal in the playbook folder and run the command:

.. code:: console

   ansible-galaxy install -r requirements.yml


Usage
=====

1. Make a copy of **default.config.yml** with the name **config.yml** and change the configurations you want to use.

2. Run the command:

.. code:: console

   ansible-playbook main.yml -i inventory --ask-become-pass


Overriding Defaults
-------------------

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in **default.config.yml** by creating a **config.yml** file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

.. code:: yaml

    installed_packages:
      - git
      - go

    snap_packages:
      - name: postman

    npm_packages:
      - name: webpack

    pip_packages:
      - name: mkdocs

Any variable can be overridden in **config.yml**; see the supporting roles' documentation for a complete list of available variables.


Use with a remote machine
-------------------------

You can use this playbook to manage other machine as well; the playbook doesn't even need to be run from a Linux computer at all! If you want to manage a remote Linux, either another Linux on your network, or a hosted Linux in the cloud, you just need to make sure you can connect to it with SSH.

Edit the **inventory** file in this repository and change the line that starts with **127.0.0.1** to:

.. code:: ini

   [ip address or hostname of linux]  ansible_user=[linux ssh username]

If you need to supply an SSH password (if you don't use SSH keys), make sure to pass the **--ask-pass** parameter to the **ansible-playbook** command.


Included Applications / Configuration (Default)
-----------------------------------------------

Packages (installed with apt):

.. code:: yaml

    - apache2-utils
    - cmake
    - git
    - guake
    - htop
    - locales-all
    - nmap
    - node
    - openssl
    - poedit
    - vagrant
    - vim
    - xclip
    - wget

Finally, there are a few other preferences and settings added on for various apps and services.


Contributing
============

Contributions are very welcome.
To learn more, see the `Contributor Guide`_.


License
=======

Distributed under the terms of the MIT_ license,
*Linux Dev Playbook* is free and open source software.


Issues
======

If you encounter any problems,
please `file an issue`_ along with a detailed description.


Credits
=======

This project was inspired by `@geerlingguy`_'s `Mac Development Ansible Playbook`_.


.. _Ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
.. _Cryptomator: https://cryptomator.org/
.. _Debian: https://www.debian.org/
.. _Download: https://github.com/staticdev/linux-developer-playbook/archive/refs/heads/main.zip
.. _Firefox: https://www.mozilla.org/firefox/
.. _Git: https://git-scm.com/
.. _Gnome: https://www.gnome.org/
.. _Google Chrome: https://www.google.com/chrome/
.. _KeyPass: https://keepass.info/
.. _MIT: https://opensource.org/licenses/MIT
.. _OBS: https://obsproject.com/
.. _OpenRGB: https://gitlab.com/CalcProgrammer1/OpenRGB
.. _Signal messenger: https://signal.org
.. _file an issue: https://github.com/staticdev/linux-dev-playbook/issues
.. _@geerlingguy: https://github.com/geerlingguy
.. _Mac Development Ansible Playbook: https://github.com/geerlingguy/mac-dev-playbook
.. github-only
.. _Contributor Guide: CONTRIBUTING.rst
