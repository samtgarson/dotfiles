#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers
source ~/.local/share/chezmoi/exact_dot_dotfiles/mac/.mas_helpers

install_apps () {
  # successfully mas_login

  successfully mas install 1176895641
  success Installed Spark

  successfully mas install 310633997
  success Installed Whatsapp

  successfully mas install 1464122853
  success Installed Next DNS

  successfully mas install 1502839586
  success Installed Hand Mirror

  successfully mas install 1572206224
  success Installed Keystroke Pro

  successfully mas install 1351639930
  success Installed Gifski

  successfully mas install 1569813296
  success Installed 1Password for Safari
}

if is_installed mas; then
  success 'mas is already installed'
else
  started Installing mas
  successfully brew install mas
  success Installed mas
fi

started Installing Mac Apps
install_apps
success Installed Mac Apps
