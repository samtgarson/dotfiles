alias k=kubectl
alias kd='kubectl describe'
alias kc='kubectl config use-context'
alias kcs='kubectl config get-contexts'
alias kg='kubectl get'

function log () {
  echo "$1" > /dev/tty
  echo > /dev/tty
}

# function pod() {
#   local po=$(kubectl get pods -o name | grep $1 | sed 's/pod\///' | head -n 1)
#   log "$fg[white]> Found $fg_bold[yellow]$po$fg_no_bold[default]"
#   echo $po
# }
#
# function pods () {
#   local po=$(kg pods | tail -n +2 | fzf -q "$1")
#
# 	if [ $po ]; then
#     local found=$(echo $po | awk -F ' ' '{ print $1 }')
#     log "$fg[white]> Found $fg_bold[yellow]$found$fg_no_bold[default]"
# 		echo $found
# 	fi
# }

alias logs='stern -s 1m --exclude "ping|metrics|HealthCheck"'

function kpf () {
  if [ $2 ]
  then
    kubectl port-forward $1 $2
  else
    kubectl port-forward $1 3000
  fi
}

function ke () {
  local po
  if [[ -z $1 ]];
    then po=$(pods)
  else
    po=$(pod $1)
  fi
  kubectl exec -it $po $2
}

function kesh () {
  ke "$1" sh
}

function kebash () {
  ke "$1" bash
}

function kwatch () {
  watch "kubectl get pods | grep $1"
}

if which kubectl >/dev/null; then
  source <(kubectl completion zsh)
fi


