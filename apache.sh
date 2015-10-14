#!/bin/bash
#
# Vagrant Shell Provisioner

# Apache
sudo apt-get -y install apache2

sudo a2dismod mpm_prefork mpm_worker
sudo a2enmod mpm_event proxy_fcgi expires rewrite actions alias

# Copy config
sudo cp -f /vagrant/vendor/xtreamwayz/vagrant-provisioner/config/apache-site.conf \
           /etc/apache2/sites-available/vagrant.conf
sudo chmod 644 /etc/apache2/sites-available/vagrant.conf
sudo chown root:root /etc/apache2/sites-available/vagrant.conf

# Enable site
sudo a2dissite 000-default.conf
sudo a2ensite vagrant.conf

# Restart
sudo service apache2 reload
