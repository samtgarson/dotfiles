# aliases
alias gprune='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d && git remote prune origin'
alias gwip='gaa && gc -m "wip" -n'

# pull master and prune, and return
function gupdate () {
  if [ $1 ]
  then
    gco $1 && gl && gprune && gco -
  else
    gco master && gl && gprune && gco -
  fi
}

# set VSCode as editor if present
if which code >/dev/null; then
  git config --global core.editor "code --wait" ;
fi

if which hub >/dev/null; then
	# Source hub aliases
  eval "$(hub alias -s)"

  alias pr='hub pull-request'
fi

