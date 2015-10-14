#!/bin/bash
#
# Vagrant Shell Provisioner

# Get the latest packages
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:ondrej/apache2
sudo add-apt-repository ppa:ondrej/php5-5.6
sudo add-apt-repository ppa:ondrej/mysql-5.6

# System tools
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y autoremove
sudo apt-get -y install nano curl git-core ntpdate cron-apt

# Set time zone
sudo timedatectl set-timezone Etc/UTC

# Update time
sudo ntpdate pool.ntp.org

# Change to /vagrant dir on login
sudo cp -f /vagrant/vendor/xtreamwayz/vagrant-provisioner/config/bash_profile /home/vagrant/.bash_profile
sudo chmod 644 /home/vagrant/.bash_profile
sudo chown vagrant:vagrant /home/vagrant/.bash_profile

# Add usefull bash tools
sudo cp -f /vagrant/vendor/xtreamwayz/vagrant-provisioner/config/bashrc /home/vagrant/.bashrc
sudo chmod 644 /home/vagrant/.bashrc
sudo chown vagrant:vagrant /home/vagrant/.bashrc
