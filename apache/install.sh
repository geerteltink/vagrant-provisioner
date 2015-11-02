#!/bin/bash
#
# Vagrant Shell Provisioner

if ! find /etc/apt/ -name *.list | xargs cat | grep ^[[:space:]]*deb | grep ondrej/apache2; then
    sudo add-apt-repository -y ppa:ondrej/apache2
    sudo apt-get -y update
fi

sudo apt-get -y install apache2

# Enable mods
sudo a2dismod mpm_prefork mpm_worker
sudo a2enmod mpm_event proxy_fcgi expires rewrite actions alias headers

# Copy config
sudo cp -f /vagrant/vendor/xtreamwayz/vagrant-provisioner/apache/vagrant.conf \
           /etc/apache2/sites-available/vagrant.conf
sudo chmod 644 /etc/apache2/sites-available/vagrant.conf
sudo chown root:root /etc/apache2/sites-available/vagrant.conf

# Enable site
sudo a2dissite 000-default.conf
sudo a2ensite vagrant.conf

# Restart
sudo service apache2 restart
