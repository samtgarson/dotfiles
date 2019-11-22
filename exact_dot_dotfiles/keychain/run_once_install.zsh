#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

if is_installed keychain; then
  success 'keychain is already installed'
else
  started Installing keychain
  successfully sudo apt-get install keychain
  success Installed keychain
fi

