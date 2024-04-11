#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

install_apps () {
  local apps=(
    1password
    coreutils
    amie
    finicky
    google-chrome
    notion
    numi
    postico
    raycast
    slack
    spotify
    trash
  )

  for app in $apps; do
    successfully brew install $app
  done
}

started 'Installing Mac apps'
install_apps
success 'Installed Mac apps'
