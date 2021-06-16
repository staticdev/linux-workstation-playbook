"""Sphinx configuration."""
from datetime import datetime


project = "Linux Developer Playbook"
author = "staticdev"
copyright = f"{datetime.now().year}, {author}"
extensions = ["sphinx.ext.autodoc", "sphinx.ext.napoleon"]
autodoc_typehints = "description"
