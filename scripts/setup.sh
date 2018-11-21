set -xe

export TEST=mysql

echo "Installing packages..."
sudo add-apt-repository ppa:jonathonf/firefox-esr-45
sudo apt-get -y update
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password temp_root_password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password temp_root_password'
sudo apt-get -y install openssh-server git vim wget curl tasksel php socat xvfb x11-utils default-jre composer zip php-zip php-curl php-mbstring mysql-server x11vnc php-dom firefox-esr php-mysql php-mysqli
mysqladmin -u root -p'temp_root_password' password ''

echo "Installing NodeJS toolset..."
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "Installing source code..."
git clone https://github.com/pkp/ojs ojs
cd ojs
./tools/startSubmodulesTRAVIS.sh

echo "Preparing the server environment..."
./lib/pkp/tools/travis/prepare-webserver.sh
source ./lib/pkp/tools/travis/start-xvfb.sh
./lib/pkp/tools/travis/start-selenium.sh
x11vnc -display :99 &

echo "Building code dependencies..."
./lib/pkp/tools/travis/install-composer-dependencies.sh
npm install && npm run build

echo "Preparing and running tests..."
source ./lib/pkp/tools/travis/prepare-tests.sh
./lib/pkp/tools/travis/run-tests.sh
