#!/usr/bin/env zsh

source ~/.dotfiles/environment.zsh
source ~/.local/share/chezmoi/.helpers

install_starship() {
  echo '▶️ Installing starship prompt'

  successfully curl -fsSL https://starship.rs/install.sh | bash

  echo '✅ Installed starship prompt'
}


if is_installed starship; then
  echo '✅ starship prompt already installed'
else
  install_starship
fi


