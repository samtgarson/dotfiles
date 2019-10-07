#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

install_asdf() {
  echo '▶️ Installing asdf'
  successfully git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.4
  successfully source ./config.zsh
  echo '✅ Installed asdf'
}

install_plugin() {
  [[ $(asdf plugin-list) =~ $1 ]] || asdf plugin-add $@
}

install_plugins() {
  echo '▶️ Installing asdf plugins'
  successfully install_plugin ruby
  successfully install_plugin nodejs
  successfully install_plugin python
  successfully install_plugin kubectl 
  successfully install_plugin helm 
  successfully install_plugin 1password

  # Install the nodejs gpg keyring to verify installs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

  echo '✅ Installed asdf plugins'
}

if [[ -e ~/.asdf ]]; then
  echo '✅ asdf already installed'
else
  successfully install_asdf
fi
install_plugins
