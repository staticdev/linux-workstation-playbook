# Podman driver installation guide

## Requirements

* Podman

## Install

Please refer to the [Virtual environment](https://virtualenv.pypa.io/en/latest/) documentation for installation best
practices. If not using a virtual environment, please consider passing the
widely recommended ['--user' flag](https://packaging.python.org/tutorials/installing-packages/#installing-to-the-user-site) when invoking ``pip``.

```sh
python3 -m pip install 'molecule-plugins[podman]' podman
```
