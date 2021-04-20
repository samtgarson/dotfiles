#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

install_apps () {
  local apps=(
    numi
    1password
    google-chrome
    slack
    notion
    spotify
    rectangle
  )

  for app in $apps; do
    successfully brew install --cask $app
  done

  brew install coreutils
}

started 'Installing Mac apps'
install_apps
success 'Installed Mac apps'
