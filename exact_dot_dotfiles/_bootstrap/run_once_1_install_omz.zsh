#!/usr/bin/env bash

source ~/.local/share/chezmoi/.helpers

omz_installed() {
  [[ -e ~/.oh-my-zsh/ ]]
}

install_oh-my-zsh() {
  started 'Installing oh-my-zsh'

  successfully wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
  RUNZSH=no successfully sh install.sh
  rm install.sh

  success 'Installed oh-my-zsh'
}

if omz_installed; then
  success 'oh-my-zsh already installed'
else
  install_oh-my-zsh
fi
