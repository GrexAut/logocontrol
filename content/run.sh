#!/bin/bash

if [ -z "$AUTH_USER" ]; then
	$(sed -i -e 's/try_files.*/proxy_pass http:\/\/127.0.0.1:8088;/g' /etc/nginx/sites-enabled/default)
else
	$(sed -i -e 's/try_files.*/proxy_pass http:\/\/127.0.0.1:8088;\n\t\tauth_basic "LogoControl Admin Area";\n\t\tauth_basic_user_file \/etc\/nginx\/.htpasswd;/g' /etc/nginx/sites-enabled/default)
	$(htpasswd -c -b /etc/nginx/.htpasswd $AUTH_USER $AUTH_PASS)
fi

service nginx start

$(/opt/LogoControl/start.sh)
