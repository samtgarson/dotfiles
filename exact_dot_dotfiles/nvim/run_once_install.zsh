#!/usr/bin/env zsh
set -e

source ~/.local/share/chezmoi/.helpers

if is_installed nvim; then
  success Neovim already installed
else
  started Installing neovim
  successfully brew install neovim
  success Installed neovim
fi
