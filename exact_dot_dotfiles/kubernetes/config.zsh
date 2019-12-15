alias k=kubectl
alias kd='kubectl describe'
alias kc='kubectl config use-context'
alias kcs='kubectl config get-contexts'
alias kg='kubectl get'

function pod() {
	kubectl get pods -o name | grep $1 | sed 's/pod\///' | head -n 1
}

function pods () {
	local pod=$(kg pods | fzf)

	if [ $pod ]; then
		echo "$(echo $pod | awk -F ' ' '{ print $1 }')"
	fi
}

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
  kubectl exec -it `pod $1` $2
}

function kebash () {
  kubectl exec -it `pod $1` bash
}

function kesh () {
  kubectl exec -it `pod $1` sh
}

function kwatch () {
  watch "kubectl get pods | grep $1"
}

if which kubectl >/dev/null; then
  source <(kubectl completion zsh)
fi


