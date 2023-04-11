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
    finicky
    cron
    raycast
  )

  for app in $apps; do
    successfully brew install --cask $app
  done

  successfully brew install coreutils
  successfully brew install trash
}

started 'Installing Mac apps'
install_apps
success 'Installed Mac apps'
