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
     webserver.vm.provision "shell", path: "scripts/provision-webserver.sh"
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
     db.vm.provision "shell", path: "scripts/provision-db.sh"
  end
end
