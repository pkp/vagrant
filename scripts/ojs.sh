echo "Installing OJS"
cd ~

# Set up the OJS database
echo "CREATE DATABASE ojs DEFAULT CHARSET utf8" | mysql -uroot -pojs
echo "CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojs'" | mysql -uroot -pojs
echo "GRANT ALL ON ojs.* TO 'ojs'@'localhost'" | mysql -uroot -pojs
echo "FLUSH PRIVILEGES" | mysql -uroot -pojs

cd www

# Clone the OJS repository
git clone -b ojs-stable-2_4_7 --single-branch https://github.com/pkp/ojs .
./tools/startSubmodulesTRAVIS.sh
cp config.TEMPLATE.inc.php config.inc.php
mkdir ~/files
chgrp -R www-data cache public ~/files config.inc.php
chmod -R ug+w cache public ~/files config.inc.php

# Install Composer dependencies
cd lib/pkp
curl -sS https://getcomposer.org/installer | php
php composer.phar update

# Install OJS
wget -O - --post-data="adminUsername=admin&adminPassword=ojsadmin&adminPassword2=ojsadmin&adminEmail=ojs@mailinator.com&locale=en_US&additionalLocales[]=en_US&clientCharset=utf-8&connectionCharset=utf8&databaseCharset=utf8&filesDir=%2fhome%2fojs%2ffiles&encryption=sha1&databaseDriver=mysql&databaseHost=localhost&databaseUsername=ojs&databasePassword=ojs&databaseName=ojs&oaiRepositoryId=ojs2.localhost" "http://localhost/ojs/index.php/index/install/install"
