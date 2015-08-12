# Update Ubuntu
apt-get -y update
#apt-get -y upgrade


# Install some useful stuff
apt-get -y install openssh-server git vim wget curl

# Install MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password ojs'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password ojs'
apt-get -y install mysql-client mysql-server

# Install LAMP server
echo "deb http://archive.ubuntu.com/ubuntu trusty multiverse" >> /etc/apt/sources.list
apt-get update
apt-get -y install php5-cgi libapache2-mod-fastcgi apache2-suexec-custom apache2-mpm-prefork

# Create an OJS account and install OJS into it.
adduser --gecos "" --disabled-password ojs
mkdir /home/ojs/www
chown ojs:ojs /home/ojs/www

# Configure Apache/FastCGI/suPHP
a2enmod actions fastcgi suexec
echo "Action application/x-httpd-php /cgi-bin/php.fcgi
SuexecUserGroup ojs ojs" | tee /etc/apache2/sites-enabled/php-fcgi.conf
sed -i -e "s,#FastCgiWrapper /usr/lib/apache2/suexec,FastCgiWrapper /usr/lib/apache2/suexec,g" /etc/apache2/mods-enabled/fastcgi.conf
sed -i -e "s,/var/www/html,/home/ojs/www,g" /etc/apache2/sites-available/000-default.conf
sed -i -e "s,/usr/lib/cgi-bin,/home/ojs/www/cgi-bin,g" /etc/apache2/sites-available/000-default.conf
#sed -i -e "s,\${APACHE_LOG_DIR},/home/ojs/www,g" /etc/apache2/sites-available/000-default.conf
sed -i -e "s,/var/www/html,/home/ojs/www/,g" /etc/apache2/suexec/ojs

# Install some additional PHP packages
apt-get -y install php5-gd php5-dev php5-xsl php-soap php5-curl

# Restart apache before we move on to installing OJS
a2enmod rewrite
service apache2 restart

su -c "sh /vagrant/scripts/ojs.sh" ojs
