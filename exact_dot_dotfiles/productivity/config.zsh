#!/usr/bin/env zsh

# Tell fzf to use ripgrep
export FZF_DEFAULT_COMMAND="rg --files -g '**' -g '!node_modules/**' -g '!.git/**' -g '!tmp/**'"

# configure z
export FZFZ_EXTRA_DIRS="~/code"
export FZFZ_EXCLUDE_PATTERN='\.git|node_modules'

# fzf integration
[[ $- == *i* ]] && source "`brew --prefix`/opt/fzf/shell/completion.zsh" 2> /dev/null # Auto complete
source "`brew --prefix`/opt/fzf/shell/key-bindings.zsh" # Keybindings

# use fd with fzf instead of find
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

kill-port () {
  local processes

  if [[ -n $1 ]]; then
    processes=$(lsof -i $1)
  else
    processes=$(lsof)
  fi
  local pid=$(echo $processes | tail -n +2 | fzf | awk -F ' ' '{ print $2 }')

  if [[ -n $pid ]]; then
    echo "Killing $pid"
    kill -9 $pid
  else
    echo 'Nothing to kill'
  fi
}

# splt - that awk thing that is annoying to type
splt () {
  local index=${1:-1}
  local divider=${2:-" "}
  awk -F $divider "{ print \$$index }"
}
