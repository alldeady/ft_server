#!/bin/bash

service mysql start

chown -R www-data /var/www/*
chmod -R 755 /var/www/*

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=RU/ST=Moscow/L=Moscow/O=42/OU=21/CN=CucumberSnowball' \
	-out /etc/ssl/certs/localhost.crt \
	-keyout /etc/ssl/certs/localhost.key

mv ./localhost.conf /etc/nginx/sites-available/localhost
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

mkdir /var/www/html/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
rm -rf phpMyAdmin-5.0.2-all-languages.tar.gz
mv ./config.inc.php /var/www/html/phpmyadmin/config.inc.php

mkdir /var/www/html/wordpress
wget https://wordpress.org/wordpress-5.4.1.tar.gz
tar -xvf wordpress-5.4.1.tar.gz --strip-components=1 -C /var/www/html/wordpress
rm -rf wordpress-5.4.1.tar.gz
mv ./wp-config.php /var/www/html/wordpress

service php7.3-fpm start
service nginx start
bash
