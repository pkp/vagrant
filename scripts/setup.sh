# Update Ubuntu
apt-get -y update && apt-get -y upgrade

# Install some useful stuff
apt-get -y install openssh-server git vim wget curl

# Set some params to automate the MySQL install
debconf-set-selections <<< 'mysql-server mysql-server/root_password password ojs'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password ojs'

# Install LAMP server
tasksel install lamp-server
usermod -a -G www-data vagrant

# Install some additional PHP packages
apt-get -y install php5-gd php5-dev php5-xsl php-soap php5-curl

# Restart apache before we move on to installing OJS
a2enmod rewrite
service apache2 restart
