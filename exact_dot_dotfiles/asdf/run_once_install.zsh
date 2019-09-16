#!/usr/bin/env bash

source ~/.local/share/chezmoi/.helpers

install_asdf() {
  echo '▶️ Installing asdf'
  successfully git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.4
  successfully source ./config.zsh
  echo '✅ Installed asdf'
}

install_plugin() {
  [[ $(asdf plugin-list) =~ $1 ]] || asdf plugin-add $1
}

install_plugins() {
  echo '▶️ Installing asdf plugins'
  successfully install_plugin ruby
  successfully install_plugin nodejs
  successfully install_plugin python
  successfully install_plugin kubectl 
  successfully install_plugin helm 
  successfully install_plugin postgres

  # Install the nodejs gpg keyring to verify installs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

  # start the postgres daemon
  pg_ctl status || pg_ctl start

  echo '✅ Installed asdf plugins'
}

if [[ -e ~/.asdf ]]; then
  echo '✅ asdf already installed'
else
  successfully install_asdf
fi
install_plugins