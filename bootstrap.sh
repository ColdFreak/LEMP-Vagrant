#!/usr/bin/env bash

# Exit if already bootstrapped
# test -f /etc/bootstrapped && exit

# Exit immediately if a command exits with a non-zero status.
set -e
function show() {
    echo "\$ $@"
    eval "$@"
}


cp -v /vagrant/conf.d/i18n /etc/sysconfig/i18n
cp -v /vagrant/conf.d/.bashrc /home/vagrant/.bashrc
chown -v vagrant:vagrant /home/vagrant/.bashrc
chmod -v 0755 /home/vagrant/.bashrc


# why use hash to check the existence of a program
# http://stackoverflow.com/questions/592620/check-if-a-program-exists-from-a-bash-script
if hash wget 2>/dev/null; then
    show yum install wget -y
fi

if [  "$(rpm -qa | grep webtatic)" != "webtatic-release-6-5.noarch" ]; then
    show rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
fi

if [ "$(rpm -qa | grep mysql-community-release-el6-5)" != "mysql-community-release-el6-5.noarch" ]; then
    show wget http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
    show yum localinstall mysql-community-release-el6-5.noarch.rpm -y
    show rm /home/vagrant/mysql-community-release-el6-5.noarch.rpm
fi


if hash vim 2>/dev/null; then
    show yum install  vim-enhanced -y
fi

if hash mlocate 2>/dev/null; then
    show yum install mlocate -y
fi

if hash git 2>/dev/null; then
    show yum install git -y
fi

if hash man 2>/dev/null; then
   show yum install man -y
fi

if [ "$(which nginx)" != "/usr/sbin/nginx" ]; then
   show yum install nginx16 -y
   show cp /vagrant/conf.d/nginx.conf /etc/nginx/nginx.conf
   show cp /vagrant/conf.d/404.html /vagrant/www/404.html
   show cp /vagrant/conf.d/50x.html /vagrant/www/50x.html
fi

if hash mysqld 2>/dev/null; then
   show yum install  mysql-community-server -y
fi

if hash php 2>/dev/null; then
   show yum install php55w -y
   show cp /vagrant/conf.d/php.ini /etc/php.ini
fi

if hash php-fpm 2>/dev/null; then
   show yum install php55w-fpm -y
   show cp /vagrant/conf.d/www.conf /etc/php-fpm.d/www.conf
fi

if [ "$(rpm -qa | grep php55w-mysql)" != "php55w-mysql-5.5.20-1.w6.x86_64" ];then
   show yum install php55w-mysql -y
fi

if [ ! -e "/etc/php.d/xdebug.ini" ]; then
   show yum install php55w-pecl-xdebug -y
   show cp /vagrant/conf.d/xdebug.ini /etc/php.d/xdebug.ini
fi
if [ ! -d "/vagrant/www" ]; then
   show mkdir /vagrant/www
fi

show sudo service nginx restart
show sudo service mysqld restart
show sudo service php-fpm start

# show sudo bash -c "date > /etc/bootstrapped"
