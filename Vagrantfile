# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Box Settings
  config.vm.define "webserver" do |webserver|
     webserver.vm.box = "trueability/ubuntu-18.04"
     webserver.vm.box_check_update = false

     # Network Settings
     webserver.vm.network "forwarded_port", guest: 80, host: 8080
     webserver.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
     webserver.vm.network "private_network", ip: "192.168.33.11"
     webserver.vm.network "public_network"

     # Folder Settings
     # For the sake of this task, no folders will be synced
     # webserver.vm.synced_folder "../data", "/vagrant_data"

     # Provider Settings
     webserver.vm.provider "virtualbox" do |vb|
       vb.gui = false
       vb.memory = "4098"
       vb.cpus = "2"
     end

    # Provision Settings
    # Wordpress setup can be found here http://192.168.33.11/wordpress/wp-admin/setup-config.php?step=1
     webserver.vm.provision "shell", inline: <<-SHELL
       apt-get update -y
       apt-get install -y apache2
       sudo apt-get install -y php libapache2-mod-php php-mysql
       sudo systemctl restart apache2.service
       sudo apt-get install memcached
       cd /var/www/html
       wget https://wordpress.org/latest.tar.gz
       tar -xzvf latest.tar.gz
       sudo rm -R latest.tar.gz
       sudo rm index.html


     SHELL
  end

  config.vm.define "db" do |db|
     db.vm.box = "trueability/ubuntu-18.04"
     db.vm.box_check_update = false

     # Network Settings
     db.vm.network "forwarded_port", guest: 3306, host: 3309
     db.vm.network "private_network", ip: "192.168.33.10"
     #db.vm.network "public_network"

     # Folder Settings
     # For the sake of this task, no folders will be synced
     # db.vm.synced_folder "../data", "/vagrant_data"

     # Provider Settings
     db.vm.provider "virtualbox" do |vb|
       # Display the VirtualBox GUI when booting the machine
       vb.gui = false
       # Customize the amount of memory on the VM:
       vb.memory = "2048"
       vb.cpus = "2"
     end

    # Provision Settings


     db.vm.provision "shell", inline: <<-SHELL
       sudo apt-get -y update

       #This is utilized to bypass the mysql password prompts during install.
       #To customize the password simply replace "root" at the end of each debconf line
       export DEBIAN_FRONTEND="noninteractive"
       sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
       sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
       sudo apt-get install -y mysql-server

       #Configure mysql
       #This block will login into your mysql instance and create a user named wordpress and a database named wordpress with password wordpress.

       echo -e "Setting up MySQL users & Databases \n"
       mysql -u root  -proot -e "CREATE DATABASE wordpress;"
       mysql -u root  -proot -e "GRANT ALL PRIVILEGES ON wordpress.* to 'wordpress'@'localhost' IDENTIFIED by 'wordpress;'"
       mysql -u root  -proot -e "ALTER USER 'wordpress'@'localhost' IDENTIFIED WITH mysql_native_password BY 'wordpress'"
       mysql -u root  -proot -e "FLUSH PRIVILEGES;"

     SHELL
  end
end
