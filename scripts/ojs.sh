echo "Installing OJS"
cd ~

# Set up the OJS database
echo "CREATE DATABASE ojs" | mysql -uroot -pojs
echo "CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojs'" | mysql -uroot -pojs
echo "GRANT ALL ON ojs.* TO 'ojs'@'localhost'" | mysql -uroot -pojs
echo "FLUSH PRIVILEGES" | mysql -uroot -pojs

cd www

# Prepare the FastCGI environment
mkdir cgi-bin
echo "#!/bin/sh
export PHP_FCGI_CHILDREN=4
export PHP_FCGI_MAX_REQUESTS=200
exec /usr/bin/php5-cgi" > cgi-bin/php.fcgi
chmod -R 755 cgi-bin

# Clone the OJS repository
git clone https://github.com/pkp/ojs ojs
cd ojs
./tools/startSubmodulesTRAVIS.sh
cp config.TEMPLATE.inc.php config.inc.php
chmod -R ug+w cache public

# Install Composer dependencies
cd lib/pkp
curl -sS https://getcomposer.org/installer | php
php composer.phar update

# Create a files directory and set permissions on it
ojs mkdir files
chmod -R ug+w files
