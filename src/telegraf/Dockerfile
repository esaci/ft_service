FROM alpine:3.11.0

ENV IP_MINIKUBE=192.168.49.50

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.13.3-static_linux_amd64.tar.gz 

RUN  tar -C . -xzf telegraf-1.13.3-static_linux_amd64.tar.gz 

RUN chmod +x telegraf/* && cp telegraf/telegraf /usr/bin/ && mkdir /etc/telegraf && mv telegraf/telegraf.conf /etc/telegraf/telegraf.conf

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

CMD telegraf
