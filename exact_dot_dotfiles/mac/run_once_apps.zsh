#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

install_apps () {
  local apps=(
    numi
    1password
    visual-studio-code
    google-chrome
    slack
  )

  for app in $apps; do
    successfully brew cask install $app
  done
}

started 'Installing Mac apps'
install_apps
success 'Installed Mac apps
