#!/usr/bin/env zsh

source ~/.dotfiles/environment.zsh
source ~/.local/share/chezmoi/.helpers

install_starship() {
  started 'Installing starship prompt'

  successfully curl -fsSL https://starship.rs/install.sh | bash

  success 'Installed starship prompt'
}


if is_installed starship; then
  success 'starship prompt already installed'
else
  install_starship
fi


