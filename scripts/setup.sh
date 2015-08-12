# Update Ubuntu
apt-get -y update
#apt-get -y upgrade

# Install some useful stuff
apt-get -y install openssh-server git vim wget curl

# Install LAMP server
debconf-set-selections <<< 'mysql-server mysql-server/root_password password ojs'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password ojs'
tasksel install lamp-server
apt-get -y install php5-gd php5-xsl php5-curl
service apache2 restart

# Create a user
adduser --gecos "" --disabled-password ojs
usermod -a -G www-data ojs

mkdir /var/www/html/ojs
chown ojs:ojs /var/www/html/ojs
ln -s /var/www/html/ojs /home/ojs/www

su -c "sh /vagrant/scripts/ojs.sh" ojs
