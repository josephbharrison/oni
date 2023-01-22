#!/usr/bin/env bash

namespace=$1
service=$2

usage(){
  usage: kube-forward <namespace> [service]
}
[[ -z $namespace ]] && usage
# kubectl command
k="kubectl -n $namespace"

# get list of services
services(){
    $k get svc -o json 2> /dev/null | jq -r .items[].spec.selector.app
}

# get list of ports
ports(){
    $k get svc -o json 2> /dev/null | jq .items[].spec.ports[0].port
}

# get port by service name
port(){
    service=$1
    $k get svc $service -o json 2> /dev/null | jq .spec.ports[0].port
}

# get service account token
sa_token(){
    sa=$($k get secrets -o json 2> /dev/null | jq -r .items[].metadata.name | grep "deploy-sa-token-")
    $k get secret $sa -o json 2> /dev/null | jq -r .data.token
}

# return first viable service
guess_service(){
    i=0
    for service in $(services)
    do
       ports=($(ports))
       port=${ports[$i]} && i=$((i+1))
       [[ $port == null ]] && continue
       # echo $service $port
       echo $service
       break
    done
}

unused_port() {
    python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()'
}

# return service URL
# [[ -z $service ]] && export spec=($(guess_service)) && service=${spec[0]}
[[ -z $service ]] && service=$(guess_service)
[[ -z $port ]] && export port=$(port $service)

case $port in
80*)
  prefix="http://";;
443)
  prefix="https://";;
*)
  prefix="";;
esac

# get unused local port
local_port=$(unused_port)

[[ -z $service ]] && echo service not found && exit 1

echo
echo "    $service.$namespace:$(port $service) -> ${prefix}localhost:$local_port"
echo

$k port-forward service/$service $local_port:$(port $service) &> /dev/null


