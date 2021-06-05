==================
Linux Dev Playbook
==================

|pre-commit|

.. |pre-commit| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
   :target: https://github.com/pre-commit/pre-commit
   :alt: pre-commit


Features
========

* These are the configuration I use for my personal development machine
* Running on "production" on Ubuntu 20.10, currently in development for Debian 11.
* Features are optional and configurable (see Usage)

Requirements
============

* Ansible_ installed: on Ubuntu you can just run:

.. code:: console

   sudo apt install ansible

Installation
============

Download or clone this repository to your local drive.

.. code:: console

   git clone git@github.com:staticdev/linux-developer-playbook.git

Install dependencies:

.. code:: console

   ansible-galaxy install -r requirements.yml

Usage
=====

1. Make a copy of `default.config.yml` with the name `config.yml` and change the configurations you want to use.

2. Run the command:

.. code:: console

   ansible-playbook main.yml -i inventory --ask-become-pass

Overriding Defaults
-------------------

Not everyone's development environment and preferred software configuration is the same.

You can override any of the defaults configured in `default.config.yml` by creating a `config.yml` file and setting the overrides in that file. For example, you can customize the installed packages and apps with something like:

    installed_packages:
      - git
      - go

    npm_packages:
      - name: webpack

    pip_packages:
      - name: mkdocs

Any variable can be overridden in `config.yml`; see the supporting roles' documentation for a complete list of available variables.


Use with a remote machine
-------------------------

You can use this playbook to manage other machine as well; the playbook doesn't even need to be run from a Linux computer at all! If you want to manage a remote Linux, either another Linux on your network, or a hosted Linux in the cloud, you just need to make sure you can connect to it with SSH.

Edit the `inventory` file in this repository and change the line that starts with `127.0.0.1` to:

.. code:: ini

   [ip address or hostname of linux]  ansible_user=[linux ssh username]

If you need to supply an SSH password (if you don't use SSH keys), make sure to pass the `--ask-pass` parameter to the `ansible-playbook` command.

Included Applications / Configuration (Default)
-----------------------------------------------

Packages (installed with apt):

  - autoconf
  - bash-completion
  - doxygen
  - gettext
  - gifsicle
  - git
  - go
  - gpg
  - hub
  - httpie
  - iperf
  - libevent
  - sqlite
  - mcrypt
  - nmap
  - node
  - nvm
  - php
  - ssh-copy-id
  - cowsay
  - readline
  - openssl
  - pv
  - wget
  - wrk

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
.. _MIT: http://opensource.org/licenses/MIT
.. _file an issue: https://github.com/staticdev/linux-dev-playbook/issues
.. _@geerlingguy: https://github.com/geerlingguy
.. _Mac Development Ansible Playbook: https://github.com/geerlingguy/mac-dev-playbook
.. github-only
.. _Contributor Guide: CONTRIBUTING.rst
