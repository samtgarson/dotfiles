source ~/.local/share/chezmoi/.helpers

# aliases
alias gprune='git branch --merged | egrep -v "(^\*|main|master|dev)" | xargs git branch -d && git remote prune origin'
alias gwip='gaa && gc -m "wip" -n'
alias gdc='gd --cached'
alias gai='git add -i'

function default-branch () {
  git symbolic-ref refs/remotes/origin/HEAD | splt 4 '/'
}

# pull master and prune, and return
function gupdate () {
  if [ $1 ]
  then
    gco $1 && gl && gprune && gco -
  else
    local target=$(default-branch)
    gco $target && gl && gprune && gco -
  fi
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
  glol --color=always \
    | fzf --ansi \
    | remove_colour \
    | sed -nr  "s/^.* ([0-9a-z]{7}) - .*$/\1/p"
}

# gfix - choose commit to fixup
gfix() {
  git commit --no-verify --fixup `sha`
}

# forgit options
alias ga='forgit::add'
alias grh='forgit::reset::head'
alias glo='forgit::log'
alias gd='forgit::diff'
alias gi='forgit::ignore'
alias gcf='forgit::checkout::file'
# alias gcb='forgit::checkout::branch'
alias gclean='forgit::clean'
alias gss='forgit::stash::show'
alias gcp='forgit::cherry::pick'
alias grbp='forgit::rebase'
