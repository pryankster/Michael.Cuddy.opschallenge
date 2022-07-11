export KUBECONFIG="$(cd $(dirname $BASH_SOURCE) && pwd)/docean-k8s-kubeconfig.yaml"
if [[ ! -f docean-k8s-kubeconfig.yaml ]]; then
    echo "Can't find k8s config file ($KUBECONFIG)!"
    echo "run 'terraform apply' in $(dirname $BASH_SOURCE)/k8s first!"
    unset KUBECONFIG
fi
