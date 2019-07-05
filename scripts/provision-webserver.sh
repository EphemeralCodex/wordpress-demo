#!/bin/bash
set -e

# create a temp directory to keep things clean
tmp=$(mktemp -d)

pushd $tmp
    # wait for apt locks on startup
    sleep 45s
    
    apt-get update -y -qq
    sudo apt-get install -y -qq \
        apache2 \
        libapache2-mod-php \
        php \
        php-mysql \
        memcached
    sudo systemctl enable apache2.service
    sudo systemctl restart apache2.service

    rm -rf /var/www/html/*
    wget -qq https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -aT wordpress /var/www/html
popd
rm -rf $tmp

exit 0
