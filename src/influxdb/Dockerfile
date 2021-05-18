FROM alpine:3.11.0

RUN apk update && apk add influxdb 

COPY srcs/start.sh /usr/sbin

EXPOSE 8086

CMD start.sh
