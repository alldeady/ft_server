FROM	debian:buster

RUN		apt-get update &&\
		apt-get upgrade -y

RUN		apt-get -y install nginx &&\
		apt-get -y install mariadb-server &&\
		apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring &&\
		apt-get -y install wget &&\
		apt-get -y install vim

COPY	./srcs/start.sh  \
		./srcs/localhost.conf \
		./srcs/wp-config.php \
		./srcs/config.inc.php \
		./srcs/auto_index.sh ./

CMD		bash start.sh
