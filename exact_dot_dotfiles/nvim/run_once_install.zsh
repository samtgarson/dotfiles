#!/usr/bin/env zsh
set -e

source ~/.local/share/chezmoi/.helpers

install_neovim () {
  sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip -y
  git clone https://github.com/neovim/neovim /tmp/neovim-install
  cd /tmp/neovim-install
  git checkout stable

  started Building neovim
  make CMAKE_BUILD_TYPE=Release
  make CMAKE_INSTALL_PREFIX=$HOME/.neovim install

  started Cleaning up
  cd -
  sudo rm -rf /tmp/neovim-install

}

if is_installed nvim; then
  success Neovim already installed
else
  started Installing neovim
  install_neovim
  success Installed neovim
fi
