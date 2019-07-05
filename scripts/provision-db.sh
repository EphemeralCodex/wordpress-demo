#!/bin/bash
set -e

# wait for apt locks on startup
sleep 45s

sudo apt-get -y update

# This is utilized to bypass the mysql password prompts during install.
# To customize the password simply replace "root" at the end of each debconf line
export DEBIAN_FRONTEND="noninteractive"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
sudo apt-get install -y mysql-server

#Configure mysql
#This block will login into your mysql instance and create a user named wordpress and a database named wordpress with password wordpress.

echo "Setting up MySQL users & Databases"
mysql -u root  -proot -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -u root  -proot -e "GRANT ALL PRIVILEGES ON wordpress.* to 'wordpress'@'%' IDENTIFIED by 'wordpress';"
# mysql -u root  -proot -e "ALTER USER 'wordpress'@'%' IDENTIFIED WITH mysql_native_password BY 'wordpress'"
mysql -u root  -proot -e "FLUSH PRIVILEGES;"

# configure mysql to listen public
sudo sed -i 's|bind-address.*=.*127.0.0.1|bind-address = 0.0.0.0|g' /etc/mysql/mysql.conf.d/mysqld.cnf

# enable and start
sudo systemctl enable mysql
sudo systemctl restart mysql