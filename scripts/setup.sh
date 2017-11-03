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

# Install a recent node/npm release (from https://www.rosehosting.com/blog/install-npm-on-ubuntu-16-04/)
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

mkdir /var/www/html/ojs
chown ojs:ojs /var/www/html/ojs
ln -s /var/www/html/ojs /home/ojs/www

su -c "sh /vagrant/scripts/ojs.sh" ojs
