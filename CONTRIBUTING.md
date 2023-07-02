# Contributor Guide

Thank you for your interest in improving this project.
This project is open-source under the [MIT license] and
welcomes contributions in the form of bug reports, feature requests, and pull requests.

Here is a list of important resources for contributors:

- [Source Code]
- [Issue Tracker]
- [Code of Conduct]

[mit license]: https://opensource.org/licenses/MIT
[source code]: https://github.com/staticdev/linux-workstation-playbook
[issue tracker]: https://github.com/staticdev/linux-workstation-playbook/issues

## How to report a bug

Report bugs on the [Issue Tracker].

When filing an issue, make sure to answer these questions:

- Which operating system and Python version are you using?
- Which version of this project are you using?
- What did you do?
- What did you expect to see?
- What did you see instead?

The best way to get your bug fixed is to provide a test case,
and/or steps to reproduce the issue.

## How to request a feature

Request features on the [Issue Tracker].

## How to set up your development environment

You need Python 3.11+ and the following tools:

- [Molecule]
- [Podman]
- [Pre-commit]
- [Vagrant] (optional)

The good thing is to install them you just need [Ansible] and this playbook.

[Pre-commit] is installed with `python_developer` tools, [Podman] and [Vagrant] with [Nix] packages by default. For [Molecule] just add it to your `pip_packages`:

```sh
pip_packages:
  - name: molecule
```

[molecule]: https://ansible.readthedocs.io/projects/molecule/en/latest/
[podman]: https://podman.io/
[pre-commit]: https://pre-commit.com/
[vagrant]: https://www.vagrantup.com/

## How to test the project

Run the tests locally:

```sh
molecule test
```

Tests are located in the `Molecule` directory and are executed in `Podman` containers.

### Using Vagrant

To provision this playbook in a VM use our `Vagrantfile` using VirtualBox or modify the file to use Libvirt.

The VM is created and provisioned with:

```sh
vagrant up
```

The default password for root in the VM is `vagrant`.

## How to submit changes

Open a [pull request] to submit changes to this project.

Your pull request needs to meet the following guidelines for acceptance:

- Pre-commit hooks need to pass.
- Include tests when relevant. This project maintains a high code coverage.
- If your changes add functionality, update the documentation accordingly.

Feel free to submit early, though—we can always iterate on this.

To run linting and code formatting checks before commiting your change, you can install pre-commit as a Git hook by running the following command:

```sh
pre-commit install
pre-commit run --all-files
```

It is recommended to open an issue before starting work on anything.
This will allow a chance to talk it over with the owners and validate your approach.

[pull request]: https://github.com/staticdev/linux-workstation-playbook/pulls
[pytest]: https://pytest.readthedocs.io/

<!-- github-only -->

[code of conduct]: CODE_OF_CONDUCT.md
