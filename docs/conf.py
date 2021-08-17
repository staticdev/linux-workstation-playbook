"""Sphinx configuration."""
from datetime import datetime


project = "Linux Workstation Playbook"
author = "staticdev"
copyright = f"{datetime.now().year}, {author}"
extensions = ["sphinx.ext.autodoc", "sphinx.ext.napoleon"]
autodoc_typehints = "description"
