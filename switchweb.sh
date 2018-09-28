#!/bin/bash

if [[ $1 == "nginx" ]]; then
	sudo systemctl stop h2o
	sudo systemctl start nginx
	sudo systemctl status nginx
elif [[ $1 == "h2o" ]]; then
	sudo systemctl stop nginx
	sudo systemctl start h2o
	sudo systemctl status h2o
else
	echo "invalid arg #{$1}"
fi
