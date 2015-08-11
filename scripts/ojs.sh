echo "Installing OJS"

# Set up the OJS database
echo "CREATE DATABASE ojs" | mysql -uroot -pojs
echo "CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojs'" | mysql -uroot -pojs
echo "GRANT ALL ON ojs.* TO 'ojs'@'localhost'" | mysql -uroot -pojs
echo "FLUSH PRIVILEGES" | mysql -uroot -pojs

# Download OJS and prepare it for installation
cd /var/www/html
git clone https://github.com/pkp/ojs
cd ojs
./tools/startSubmodulesTRAVIS.sh
cp config.TEMPLATE.inc.php config.inc.php
chown -R www-data:www-data .
chmod -R ug+w .

# Install Composer dependencies
cd lib/pkp
curl -sS https://getcomposer.org/installer | php
php composer.phar update

# Create a handy symlink from the home directory
cd ~vagrant
ln -s /var/www/html/ojs .

# Create a files directory and set permissions on it
mkdir files
chown -R www-data:www-data files
chmod -R ug+w files
