# Update Ubuntu
apt-get -y update
#apt-get -y upgrade

# Install some useful stuff
apt-get -y install openssh-server git vim wget curl

# Set some params to automate the MySQL install
debconf-set-selections <<< 'mysql-server mysql-server/root_password password ojs'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password ojs'

# Install LAMP server
apt-get -y install php5-cgi libapache2-mod-fastcgi apache2-suexec-custom apache2-mpm-prefork

# Configure Apache/FastCGI/suPHP
a2enmod actions fastcgi suexec
echo "Action application/x-httpd-php /cgi-bin/php.fcgi
SuexecUserGroup ojs ojs" | tee /etc/apache2/sites-enabled/php-fcgi.conf
mkdir cgi-bin
echo "#!/bin/sh
export PHP_FCGI_CHILDREN=4
export PHP_FCGI_MAX_REQUESTS=200
exec /usr/bin/php5-cgi" > cgi-bin/php.fcgi
chmod -R 755 cgi-bin
sed -i -e "s,#FastCgiWrapper /usr/lib/apache2/suexec,FastCgiWrapper /usr/lib/apache2/suexec,g" /etc/apache2/mods-enabled/fastcgi.conf
sed -i -e "s,/var/www,$(pwd),g" /etc/apache2/sites-available/default
sed -i -e "s,/usr/lib/cgi-bin,$(pwd)/cgi-bin,g" /etc/apache2/sites-available/default
sed -i -e "s,\${APACHE_LOG_DIR},$(pwd),g" /etc/apache2/sites-available/default
sed -i -e "s,/var/www,$(pwd)/,g" /etc/apache2/suexec/www-data

# Install some additional PHP packages
apt-get -y install php5-gd php5-dev php5-xsl php-soap php5-curl

# Restart apache before we move on to installing OJS
a2enmod rewrite
service apache2 restart
