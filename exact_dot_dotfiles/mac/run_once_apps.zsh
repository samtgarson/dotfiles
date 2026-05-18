#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

install_apps () {
  local apps=(
    1password
    claude-code
    coreutils
    finicky
    ghostty
    google-chrome
    mackup
    notion
    pixelsnap
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
