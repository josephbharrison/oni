#!/usr/bin/env bash

namespace=$1
service=$2

usage(){
  usage: kube-proxy <namespace> [service]
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
       echo $service $port
       break
    done
}


# return service URL
[[ -z $service ]] && export spec=($(guess_service)) && service=${spec[0]} && port=${spec[1]}

echo
echo "    http://localhost:8001/api/v1/namespaces/$namespace/services/$service:$(port $service)/proxy/"
echo

kubectl proxy &> /dev/null

