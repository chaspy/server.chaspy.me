#!/bin/bash

if [[ $1 == "nginx" ]]; then
	sudo systemctl stop h2o
	sudo systemctl stop apache2
	sudo systemctl start nginx
	sudo systemctl status nginx
elif [[ $1 == "h2o" ]]; then
	sudo systemctl stop nginx
	sudo systemctl stop apache2
	sudo systemctl start h2o
	sudo systemctl status h2o
elif [[ $1 == "apache2" ]]; then
	sudo systemctl stop nginx
	sudo systemctl stop h2o
	sudo systemctl start apache2
	sudo systemctl status apache2

else
	echo "invalid arg #{$1}"
fi
