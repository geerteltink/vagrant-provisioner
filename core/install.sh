#!/bin/bash
#
# Vagrant Shell Provisioner

# Get the latest packages
sudo apt-get -y install software-properties-common

if ! find /etc/apt/ -name *.list | xargs cat | grep ^[[:space:]]*deb | grep git-core/ppa; then
    sudo add-apt-repository ppa:git-core/ppa
fi

# System tools
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get -y autoremove
sudo apt-get -y install sudo nano curl git-core ntpdate cron-apt

# Set time zone
sudo timedatectl set-timezone Etc/UTC

# Update time
sudo ntpdate pool.ntp.org

# Change to /vagrant dir on login
sudo cp -f /vagrant/vendor/xtreamwayz/vagrant-provisioner/core/bash_profile /home/vagrant/.bash_profile
sudo chmod 644 /home/vagrant/.bash_profile
sudo chown vagrant:vagrant /home/vagrant/.bash_profile

# Add usefull bash tools
sudo cp -f /vagrant/vendor/xtreamwayz/vagrant-provisioner/core/bashrc /home/vagrant/.bashrc
sudo chmod 644 /home/vagrant/.bashrc
sudo chown vagrant:vagrant /home/vagrant/.bashrc
