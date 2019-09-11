#!/usr/bin/env zsh 

source ~/.local/share/chezmoi/.helpers
source ~/.dotfiles/environment.zsh

plugin_dir="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

if [[ -e $plugin_dir ]]; then
  success 'zsh syntax highlighting is already installed'
else
  started Installing zsh syntax highlighting

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $plugin_dir
  
  success Installed zsh syntax highlighting 
fi

