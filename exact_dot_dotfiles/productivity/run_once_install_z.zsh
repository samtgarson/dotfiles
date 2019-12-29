#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

z_path=~/.dotfiles/productivity/z.sh

if [[ -f $z_path ]]; then
  success 'z is already installed'
else
  started Installing z
  curl -o $z_path https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/z/z.sh
  success Installed z
fi

