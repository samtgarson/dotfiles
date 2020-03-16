#!/usr/bin/env zsh

# Tell fzf to use ripgrep
export FZF_DEFAULT_COMMAND='rg --files'

# configure z
source ~/.dotfiles/productivity/z.sh
export FZFZ_EXTRA_DIRS="~/code"
export FZFZ_EXCLUDE_PATTERN='\.git|node_modules'

# use fd with fzf instead of find
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --exclude "node_modules" . "$1"
}

# gco - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  if [[ -n $1 ]]; then
    git checkout $1
    return
  fi

  local branches branch current_branch
  current_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" | grep -wv $current_branch |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
alias gco='fbr'

# get a sha from the logs
sha() {
  glol --color=always\
    | fzf --ansi \
    | sed -nr  "s/^.* ([0-9a-z]{7}) - .*$/\1/p"
}

# gfix - choose commit to fixup
gfix() {
  git commit --no-verify --fixup `sha`
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
  awk -F ' ' "{ print \$$1 }"
}
