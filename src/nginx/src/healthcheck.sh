#!/bin/bash


while sleep 20;
do
	if ! pgrep "nginx"
	then
		exit 1
	fi
	if ! pgrep "sshd"
	then
		exit 1
	fi
done
