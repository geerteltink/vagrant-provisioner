#!/bin/bash
#
# Vagrant Shell Provisioner

# PHP
sudo apt-get -y install php5-cli php5-fpm php5-mcrypt php5-mysql php5-sqlite php5-gd php5-intl php5-curl php5-xdebug

# Enable extensions
sudo php5enmod xdebug

# Configure opcache
sudo cp /vagrant/vendor/xtreamwayz/vagrant-provisioner/config/opcache.ini \
        /etc/php5/mods-available/opcache.ini
sudo chmod 644 /etc/php5/mods-available/opcache.ini

# Setup Apache
sudo cp /vagrant/vendor/xtreamwayz/vagrant-provisioner/config/php5-fpm.conf \
        /etc/apache2/conf-available/php5-fpm.conf
sudo chmod 644 /etc/apache2/conf-available/php5-fpm.conf
sudo a2enconf php5-fpm

# Composer
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/bin/composer

# Z-Ray
if [ ! -f zray-php5.6-Ubuntu-14.04-x86_64.tar.gz ]; then
    sudo wget --progress=bar:force http://downloads.zend.com/zray/1208/zray-php5.6-Ubuntu-14.04-x86_64.tar.gz
fi
sudo tar xvfz zray-php5.6-Ubuntu-14.04-x86_64.tar.gz -C /opt
sudo cp -f /opt/zray/zray-ui.conf /etc/apache2/sites-available
sudo chmod 644 /etc/apache2/sites-available/zray-ui.conf
sudo a2ensite zray-ui.conf
sudo chown -R www-data:www-data /opt/zray
sudo ln -sf /opt/zray/zray.ini /etc/php5/fpm/conf.d/zray.ini
# Disable z-ray in cli
#sudo ln -sf /opt/zray/zray.ini /etc/php5/cli/conf.d/zray.ini

# Restart
sudo service apache2 reload
sudo service php5-fpm restart
