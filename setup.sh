#!/bin/sh



minikube start --vm-driver=docker --cpus=2  --extra-config=apiserver.service-node-port-range=20-65535

IP_TO_SUBST="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
export IP_TO_SUBST=$IP_TO_SUBST
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml 
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml 

envsubst '$IP_TO_SUBST' < ./src/manifests/metallb-config.yaml  > ./src/yaml/metallb-config.yaml
kubectl apply -f ./src/yaml/metallb-config.yaml

envsubst '$IP_TO_SUBST' < src/nginx/src/patron.conf > src/nginx/src/nginx.conf
envsubst '$IP_TO_SUBST' < src/manifests/nginx.yaml > src/yaml/nginx.yaml
envsubst '$IP_TO_SUBST' < src/manifests/grafana.yaml > src/yaml/grafana.yaml
envsubst '$IP_TO_SUBST' < src/manifests/phpmyadmin.yaml > src/yaml/phpmyadmin.yaml
envsubst '$IP_TO_SUBST' < src/manifests/wordpress.yaml > src/yaml/wordpress.yaml
envsubst '$IP_TO_SUBST' < src/manifests/ftps.yaml > src/yaml/ftps.yaml
eval $(minikube docker-env)

docker build -t e_nginx src/nginx > /dev/null 2>&1
kubectl apply -f ./src/yaml/nginx.yaml


docker build -t e_phpmyadmin src/phpmyadmin > /dev/null 2>&1
kubectl apply -f ./src/yaml/phpmyadmin.yaml

docker build -t e_mysql src/mysql > /dev/null 2>&1
kubectl apply -f ./src/yaml/mysql.yaml


docker build -t e_wordpress src/wordpress > /dev/null 2>&1
kubectl apply -f ./src/yaml/wordpress.yaml 


docker build -t e_ftps src/ftps > /dev/null 2>&1
kubectl apply -f ./src/yaml/ftps.yaml

docker build -t e_influxdb src/influxdb > /dev/null 2>&1
kubectl apply -f ./src/yaml/influxdb.yaml

docker build -t e_telegraf src/telegraf > /dev/null 2>&1
kubectl apply -f ./src/yaml/telegraf.yaml


docker build -t e_grafana src/grafana > /dev/null 2>&1
kubectl apply -f ./src/yaml/grafana.yaml

minikube dashboard