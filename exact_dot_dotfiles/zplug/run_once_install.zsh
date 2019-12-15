#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers
source ~/.dotfiles/environment.zsh

if [[ -n $ZPLUG_HOME ]]; then
  success 'zplug is already installed'
else
  started Installing zplug

  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  success Installed zplug
fi

