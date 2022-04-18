mkdir $1
cd $1
year=$(date +'%Y')
echo 'MIT License

Copyright (c) $year Essameldin Gouda

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.' > LICENSE
echo '[build-system]
requires = ["setuptools>=42.0", "wheel"]
build-backend = "setuptools.build_meta"
' > pyproject.toml
mkdir $1
touch $1/__init__.py
echo "# $1 (UNDER DEVELOPMENT)" > README.md
echo "coverage
flake8
mypy
pytest
pytest-cov
tox
" > requirements-dev.txt
echo "[metadata]
name = $1
version = 0.0.1
description = $1
long_description = file: README.md
long_description_content_type = text/markdown
url = https://github.com/essamgouda97/$1
author = Essam Gouda
author_email = essamgouda97@hotmail.com
license = MIT
license_file = LICENSE
classifiers =
    License :: OSI Approved :: MIT License
    Programming Language :: Python :: 3
    Programming Language :: Python :: 3 :: Only
    Programming Language :: Python :: 3.6
    Programming Language :: Python :: 3.7
    Programming Language :: Python :: 3.8
    Programming Language :: Python :: 3.9
    Programming Language :: Python :: 3.10
    Programming Language :: Python :: Implementation :: CPython
    Programming Language :: Python :: Implementation :: PyPy
long_descrtipion = file: README.md

[options]
packages = find:
python_requires = >=3.6

[options.packages.find]
exclude =
    tests*
    testing*

[bdist_wheel]
universal = True

[coverage:run]
plugins = covdefaults

[mypy]
check_untyped_defs = true
disallow_any_generics = true
disallow_incomplete_defs = true
disallow_untyped_defs = true
no_implicit_optional = true
warn_redundant_casts = true
warn_unused_ignores = true

[mypy-testing.*]
disallow_untyped_defs = false

[mypy-tests.*]
disallow_untyped_defs = false

[flake8]
max-line-length = 160
" > setup.cfg
echo "from __future__ import annotations

from setuptools import setup
setup()
" > setup.py
mkdir tests
touch tests/__init__.py
echo "[tox]
envlist = py36,py37,py38,pypy3
skip_missing_interpreters = true

[testenv]
deps = -rrequirements-dev.txt
setenv =
    GIT_AUTHOR_NAME = "test"
    GIT_COMMITTER_NAME = "test"
    GIT_AUTHOR_EMAIL = "test@example.com"
    GIT_COMMITTER_EMAIL = "test@example.com"
commands =
    coverage erase
    coverage run -m pytest {posargs:tests}
    coverage report

[testenv:pre-commit]
skip_install = true
commands = pre-commit run --all-files --show-diff-on-failure

[pep8]
ignore=E265,E501,W504
" > tox.ini
echo "*.egg-info
*.pyc
.coverage
.tox
/venv*
dist" > .gitignore
mkdir -p .github/workflows
echo "name: pre-commit

on:
  pull_request:
  push:
    branches: [main]

jobs:
  pre-commit:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: actions/setup-python@v2
    - uses: pre-commit/action@v2.0.2" > .github/workflows/pre-commit.yml
echo "repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.1.0
    hooks:
    - id: trailing-whitespace
    - id: end-of-file-fixer
    - id: check-docstring-first
    - id: check-json
    - id: check-added-large-files
    - id: check-yaml
    - id: debug-statements
    - id: name-tests-test
    - id: double-quote-string-fixer
    - id: requirements-txt-fixer
-   repo: https://github.com/PyCQA/flake8
    rev: 4.0.1
    hooks:
    - id: flake8
      additional_dependencies: [flake8-typing-imports==1.7.0]
-   repo: https://github.com/pre-commit/mirrors-autopep8
    rev: v1.6.0
    hooks:
    - id: autopep8
-   repo: https://github.com/asottile/reorder_python_imports
    rev: v2.6.0
    hooks:
    - id: reorder-python-imports
      args: [--py36-plus, --add-import, 'from __future__ import annotations']
-   repo: https://github.com/asottile/pyupgrade
    rev: v2.31.0
    hooks:
    - id: pyupgrade
      args: [--py36-plus]
-   repo: https://github.com/asottile/add-trailing-comma
    rev: v2.2.1
    hooks:
    - id: add-trailing-comma
      args: [--py36-plus]
-   repo: https://github.com/asottile/setup-cfg-fmt
    rev: v1.20.0
    hooks:
    - id: setup-cfg-fmt
-   repo: https://github.com/pre-commit/mirrors-mypy
    rev: v0.931
    hooks:
    - id: mypy
      additional_dependencies: [types-all]
" > .pre-commit-config.yaml

