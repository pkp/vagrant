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
cp ojs/config.TEMPLATE.inc.php ojs/config.inc.php

# Set permissions on the ojs directory. This command is
# too permissive but that's OK for this VM.
chown -R www-data:www-data ojs
chmod -R ug+w ojs

# Create a files directory and set permissions on it
cd /var/www
mkdir files
chown -R www-data:www-data files
chmod -R ug+w files
