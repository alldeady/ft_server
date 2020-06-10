#!/bin/bash

if grep -q "autoindex on" /etc/nginx/sites-available/localhost
then
	sed -i 's/autoindex on/autoindex off/' /etc/nginx/sites-available/localhost
	service nginx restart
elif grep -q "autoindex off" /etc/nginx/sites-available/localhost
then
	sed -i 's/autoindex on/autoindex on/' /etc/nginx/sites-available/localhost
	service nginx restart
fi
