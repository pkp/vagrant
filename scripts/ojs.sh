echo "Installing OJS"

# Create ojs user and home dir
adduser ojs

# Set up the OJS database
echo "CREATE DATABASE ojs" | mysql -uroot -pojs
echo "CREATE USER 'ojs'@'localhost' IDENTIFIED BY 'ojs'" | mysql -uroot -pojs
echo "GRANT ALL ON ojs.* TO 'ojs'@'localhost'" | mysql -uroot -pojs
echo "FLUSH PRIVILEGES" | mysql -uroot -pojs

# Prepare for OJS download and installation
cd /var/www/html
mkdir ojs
chown ojs:ojs ojs

# Run the remainder of the OJS installation as the ojs user
cd /var/www/html
sudo -u ojs git clone https://github.com/pkp/ojs ojs
cd ojs
sudo -u ojs ./tools/startSubmodulesTRAVIS.sh
sudo -u ojs cp config.TEMPLATE.inc.php config.inc.php
chmod -R ug+w cache public

# Install Composer dependencies
cd lib/pkp
curl -sS https://getcomposer.org/installer | php
php composer.phar update

# Create a handy symlink from the home directory
cd /home/ojs
sudo -u ojs ln -s /var/www/html/ojs .

# Create a files directory and set permissions on it
sudo -u ojs mkdir files
chmod -R ug+w files
