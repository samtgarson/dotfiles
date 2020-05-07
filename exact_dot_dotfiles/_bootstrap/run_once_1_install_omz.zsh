#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

if [[ $SHELL != `which zsh` ]]; then
  warn 'Start a new session and run chezmoi apply again'
fi

omz_installed() {
  [[ -e ~/.oh-my-zsh/ ]]
}

install_oh-my-zsh() {
  started 'Installing oh-my-zsh'

  successfully curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
  RUNZSH=no successfully sh install.sh
  rm install.sh

  success 'Installed oh-my-zsh'
}

if omz_installed; then
  success 'oh-my-zsh already installed'
else
  install_oh-my-zsh
fi

