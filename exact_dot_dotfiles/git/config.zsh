source ~/.local/share/chezmoi/.helpers

# aliases
function gprune() {
  git branch --merged | egrep -v "(^\*|main|master|dev)" | xargs git branch -d && git remote prune origin

  git checkout -q $(default-branch)
  git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do
    local mergeBase=$(git merge-base $(default-branch) $branch)
    local temp_commit=$(git commit-tree $(git rev-parse "$branch^{tree}") -p $mergeBase -m _)
    if [[ $(git cherry $(default-branch) $temp_commit) == "-"* ]]; then
      git branch -D $branch;
    fi
  done

}
alias gwip='gaa && gc -m "wip" -n'
alias gdc='gd --cached'
alias gai='git add -i'
alias lg='lazygit'

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
gcheckout() {
  if [[ -n $1 ]]; then
    git checkout $1
    return
  fi

  forgit::checkout::branch
}
alias gco='gcheckout'

# get a sha from the logs
sha() {
  glol --color=always \
    | fzf --ansi \
    | remove_colour \
    | sed -nr  "s/^.* ([0-9a-z]{7,8}) - .*$/\1/p"
}

# gfix - choose commit to fixup
gfix() {
  git commit --no-verify --fixup `sha`
}

# jirabr - open a branch for a JIRA ticket
jirabr () {
  zmodload zsh/zutil
  zparseopts -D -E -F - b:=base -base:=base t:=type -type:=type -no-checkout=nocheckout || return 1
  base="${base[-1]:-`default-branch`}"
  type="${type[-1]:-feature}"
  nocheckout="${nocheckout[-1]}"

  issue=$1
  if [ -z "${@:2}" ]; then
    sentence=$(jira view $issue -t debug | jq '.fields.summary[0:50]' -r)
  else
    sentence="${@:2}"
  fi

  str=$( echo "$sentence" \
   | awk '{print(tolower($0))}' \
   | sed 's/ *$//' \
   | sed 's/[^a-z0-9_ ]//g')
  parts=(${(@s: :)str})
  joined="$parts[0,10]"
  title=$(echo $joined | sed 's/ /-/g')

  branch="$type/prod-$issue-$title"
  existing=$(git branch --format "%(refname:short)" | grep $title | sed 's/ *$//' | sed 's/^ *//')

  if [[ $nocheckout -eq 0 ]]; then git checkout $base; fi
  if [[ -n $existing ]]; then
    git checkout $existing
  else
    git checkout -b $branch
  fi
}
