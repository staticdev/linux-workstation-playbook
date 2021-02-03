"""Sphinx configuration."""
from datetime import datetime


project = "Git Portfolio"
author = "Thiago Carvalho D'Ávila"
copyright = f"{datetime.now().year}, {author}"
extensions = ["sphinx.ext.autodoc", "sphinx.ext.napoleon", "sphinx_click"]
autodoc_typehints = "description"
