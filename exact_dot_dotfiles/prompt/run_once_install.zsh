#!/usr/bin/env zsh 

source ~/.dotfiles/environment.zsh
source ~/.local/share/chezmoi/.helpers

install_spaceship() {
  echo '▶️ Installing spaceship prompt'

  successfully git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  successfully ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  
  echo '✅ Installed spaceship prompt'
}


if [[ -e $ZSH_CUSTOM/themes/spaceship-prompt ]]; then
  echo '✅ spaceship prompt already installed'
else
  install_spaceship
fi

