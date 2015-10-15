#!/bin/bash
#
# Vagrant Shell Provisioner

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
sudo apt-get install -y mysql-server

# Copy config
sudo cp -f /vagrant/vendor/xtreamwayz/vagrant-provisioner/config/my.cnf /etc/mysql/my.cnf
sudo chmod 644 /etc/mysql/my.cnf
sudo chown root:root /home/vagrant/.bashrc

# Restart
sudo /etc/init.d/mysql restart

# Create vagrant user and database
mysql -uroot -pvagrant -e "CREATE DATABASE IF NOT EXISTS vagrant;"
mysql -uroot -pvagrant -e "GRANT ALL PRIVILEGES ON vagrant.* TO vagrant@localhost IDENTIFIED BY 'vagrant'"
