#!/bin/bash

set -euo pipefail

if [ "${CODESPACES}" = "true" ]; then
    sudo apt install -yqq stow
fi

if [ ! -d "$HOME/bin" ]; then
  mkdir "$HOME/bin"
fi

stow -t ~/bin bin
stow ruby
stow shell
stow vim
stow psql
stow git


