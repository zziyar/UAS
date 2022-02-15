FROM Mysql

COPY  Trucorp.sql /var/www/html 

docker network  CREATE Trucorp

RUN --name Trucorp-web --network Trucorp -e MYSQL_ROOT_PASSWORD = "UAS" -v Desktop:/var/lib/mysql -p 6000:80 -d mysql

FROM phpMyAdmin
RUN --name Trucorp-web --network Trucorp -e PMA_HOST = ""  -p 6000:80 -d phpmyadmin/phpmyadmin

FROM php:7.4-cli
RUN --name Trucorp-web -v docker:/var/www/html/ -p 6000:80 --network Trucorp -d php:apache

RUN chmod 774 /.
