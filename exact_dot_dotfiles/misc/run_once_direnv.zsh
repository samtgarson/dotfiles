#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

function install_direnv() {
  started Installing direnv

  successfully brew install direnv

  success Installed direnv
}


if is_brew_installed direnv; then
  success 'direnv is already installed'
else
  successfully install_direnv
fi


