#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers
source ~/.dotfiles/environment.zsh

function install_delta() {
  started Installing delta

  successfully brew install git-delta

  success Installed delta
}


if which delta > /dev/null; then
  success 'delta is already installed'
else
  successfully install_delta
fi

