#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

if is_cask_installed iterm2; then
  success 'iterm2 is already installed'
else
  started Installing iterm2
  successfully brew install --cask iterm2
  success Installed iterm2
fi

