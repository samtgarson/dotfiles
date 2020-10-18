#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers
source ~/.local/share/chezmoi/exact_dot_dotfiles/mac/.mas_helpers

install_apps () {
  successfully mas_login

  successfully mas install 1176895641
  success Installed Spark

  successfully mas install 1147396723
  success Installed Whatsapp

  successfully mas install 904280696
  success Installed Things

  successfully mas install 975937182
  success Installed Fantastical

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

