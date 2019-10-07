#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

install_tpm() {
  starting '▶️ Installing tpm'
  successfully git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
  success '✅ Installed tpm'
}

if [[ -e ~/.tmux/plugins/tpm ]]; then
  success '✅ tpm already installed'
else
  successfully install_tpm
fi
