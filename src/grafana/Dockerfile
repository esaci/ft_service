FROM alpine:3.13.0


ENV IP_MINIKUBE=192.168.49.50

RUN apk update && apk add grafana --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

RUN mkdir -p /usr/share/grafana/dashboards

COPY srcs/grafana.ini /usr/share/grafana/conf/grafana.ini

COPY srcs/influxdb_data.yaml /usr/share/grafana/conf/provisioning/datasources/

COPY srcs/default.yaml /usr/share/grafana/conf/provisioning/dashboards/default.yaml

COPY srcs/dashboards/* /usr/share/grafana/dashboards/

EXPOSE 3000

WORKDIR /usr/share/grafana
#CMD sleep infinity & wait
CMD grafana-server --config conf/grafana.ini