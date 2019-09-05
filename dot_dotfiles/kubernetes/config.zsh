alias k=kubectl
alias kd='kubectl describe'
alias kc='kubectl config use-context'
alias kcs='kubectl config get-contexts'
alias kg='kubectl get'

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
  kubectl exec -it $1 $2
}

function kebash () {
  kubectl exec -it $1 bash
}

function kesh () {
  kubectl exec -it $1 sh
}

function kgrep () {
  kubectl get pods -oname | grep $1
}

function kwatch () {
  watch "kubectl get pods | grep $1"
}


