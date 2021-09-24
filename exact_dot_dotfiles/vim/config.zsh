#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

alias nvim="NVIM_LISTEN_ADDRESS=./.nvimsocket nvim"
alias vim=nvim
alias vi=nvim
alias v="vim ."

if is_installed 'nvr'; then
  export GIT_EDITOR="nvr --servername .nvimsocket --remote-tab-wait -s"
else
  export GIT_EDITOR="nvim"
fi

