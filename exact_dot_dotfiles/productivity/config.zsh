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

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# gfix - choose commit to fixup
gfix() {
  glol --color=always\
    | fzf --ansi \
    | sed -nr  "s/^.* ([0-9a-z]{7}) - .*$/\1/p" \
    | xargs git commit --no-verify --fixup
}
