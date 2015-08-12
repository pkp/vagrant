echo "Installing OJS"
cd ~

# Set up the OJS database
echo "CREATE DATABASE ojs DEFAULT CHARSET utf8" | mysql -uroot -pojs
echo "CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojs'" | mysql -uroot -pojs
echo "GRANT ALL ON ojs.* TO 'ojs'@'localhost'" | mysql -uroot -pojs
echo "FLUSH PRIVILEGES" | mysql -uroot -pojs

cd www

# Clone the OJS repository
git clone https://github.com/pkp/ojs .
./tools/startSubmodulesTRAVIS.sh
cp config.TEMPLATE.inc.php config.inc.php
mkdir ~/files
chgrp -R www-data cache public ~/files config.inc.php
chmod -R ug+w cache public ~/files config.inc.php

# Install Composer dependencies
cd lib/pkp
curl -sS https://getcomposer.org/installer | php
php composer.phar update

# Create a files directory and set permissions on it
mkdir files
