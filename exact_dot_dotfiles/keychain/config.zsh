if [[ -f "$HOME/.ssh/id_rsa" ]]; then
  eval "$(keychain -q --eval --agents ssh id_rsa)"
fi
