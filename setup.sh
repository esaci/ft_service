#!/bin/sh

IP_TO_SUBST="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
export IP_TO_SUBST=$IP_TO_SUBST

minikube start --vm-driver=docker --cpus=2  --extra-config=apiserver.service-node-port-range=20-65535

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml 
envsubst '$IP_TO_SUBST' < ./src/manifests/metallb-config.yaml  > ./src/yaml/metallb-config.yaml
kubectl apply -f ./src/yaml/metallb-config.yaml

envsubst '$IP_TO_SUBST' < src/manifests/nginx.yaml > src/yaml/nginx.yaml

docker build -t nginx src/nginx > /dev/null 2>&1
kubectl apply -f ./src/yaml/nginx.yaml
