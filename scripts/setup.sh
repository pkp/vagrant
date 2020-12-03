set -xe

ACCOUNT=$1
APPLICATION=$2
BRANCH=$3

export TEST=mysql

echo "Installing packages..."
sudo locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
sudo add-apt-repository -y ppa:ondrej/php

sudo apt-get -y update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password temp_root_password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password temp_root_password'
sudo apt-get -y install openssh-server git vim wget curl tasksel php socat zip php-zip php-intl php-curl php-mbstring mysql-server php-mysql php-xml xvfb libxss1
wget --progress=dot https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt -y install ./google-chrome-stable_current_amd64.deb
sudo apt-get purge -y apache2
mysqladmin -u root -p'temp_root_password' password ''

echo "Installing modern Composer..."
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
sudo php composer-setup.php --install-dir=/usr/bin --filename=composer
rm composer-setup.php

echo "Installing NodeJS toolset..."
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing source code..."
git clone -b ${BRANCH} --single-branch https://github.com/${ACCOUNT}/${APPLICATION} ${APPLICATION}
cd ${APPLICATION}
./tools/startSubmodulesTRAVIS.sh

echo "Preparing the server environment..."
./lib/pkp/tools/travis/prepare-webserver.sh

echo "Building code dependencies..."
./lib/pkp/tools/travis/install-composer-dependencies.sh
npm install && npm run build

set +xe

echo "Preparing and running tests..."
source ./lib/pkp/tools/travis/prepare-tests.sh
lib/pkp/tools/travis/run-tests.sh
