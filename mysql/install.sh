#!/bin/bash
#
# Vagrant Shell Provisioner

#if ! find /etc/apt/ -name *.list | xargs cat | grep ^[[:space:]]*deb | grep ondrej/mysql-5.6; then
#    sudo add-apt-repository -y ppa:ondrej/mysql-5.6
#    sudo apt-get -y update
#fi

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
sudo apt-get -y install mysql-server

# Copy config
sudo cp -f /vagrant/vendor/xtreamwayz/vagrant-provisioner/mysql/my.cnf /etc/mysql/my.cnf
sudo chmod 644 /etc/mysql/my.cnf

# Restart
sudo service mysql restart

# Create vagrant user and database
mysql -uroot -pvagrant -e "CREATE DATABASE IF NOT EXISTS vagrant;"
mysql -uroot -pvagrant -e "GRANT ALL PRIVILEGES ON vagrant.* TO vagrant@localhost IDENTIFIED BY 'vagrant'"
