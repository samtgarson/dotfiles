eval $(/opt/homebrew/bin/brew shellenv)

add_spacer_to_doc() {
  defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="small-spacer-tile";}'; killall Dock
}
