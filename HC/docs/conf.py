import sys
import os
import shlex

extensions = [
    'sphinx.ext.mathjax',
]

templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'


project = u'HC'
copyright = u'2015, Matthias Richter'
author = u'Matthias Richter'

version = '0.1'
release = '0.1-1'
language = None
exclude_patterns = ['_build']
pygments_style = 'sphinx'

todo_include_todos = False

html_static_path = ['_static']

htmlhelp_basename = 'HCdoc'

latex_elements = {
latex_documents = [
  (master_doc, 'HC.tex', u'HC Documentation',
   u'Matthias Richter', 'manual'),
]

man_pages = [
    (master_doc, 'hc', u'HC Documentation',
     [author], 1)
]

texinfo_documents = [
  (master_doc, 'HC', u'HC Documentation',
   author, 'HC', 'One line description of project.',
   'Miscellaneous'),
]

primary_domain = "js"
highlight_language = "lua"

import sphinx_rtd_theme
html_theme = 'sphinx_rtd_theme'
html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
