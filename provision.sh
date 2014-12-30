#!/bin/bash

php_config_file="/etc/php5/apache2/php.ini"
xdebug_config_file="/etc/php5/mods-available/xdebug.ini"
mysql_config_file="/etc/mysql/my.cnf"
craft_version="2.3"
craft_build="2621"
mysql_db="craft"
mysql_pass="root"

#Set Locale
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')
echo $IPADDR ubuntu.localhost >> /etc/hosts			# Just to quiet down some error messages

# Update the server
apt-get update > /dev/null && echo "Updating Server..."
apt-get -y upgrade > /dev/null && echo "Upgrading Software..."

# Install basic tools
apt-get -y install build-essential binutils-doc git > /dev/null && echo "Installing basic tools..."

# Install Apache
apt-get -y install apache2 > /dev/null && echo "Installing Apache..."
apt-get -y install php5 php5-curl php5-mysql php5-sqlite php5-xdebug > /dev/null && echo "Installing PHP..."

sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
echo "xdebug.remote_enable=On" >> ${xdebug_config_file}
echo 'xdebug.remote_connect_back=On' >> ${xdebug_config_file}

# Install MySQL
echo "mysql-server mysql-server/root_password password ${mysql_pass}" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-client mysql-server > /dev/null && echo "Installing MySQL..."

sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" ${mysql_config_file}

# Create craft database
echo "Creating database with name $mysql_db..."
echo "create database ${mysql_db}" | mysql -u root --password=${mysql_pass}

# Allow root access from any host
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION" | mysql -u root --password=${mysql_pass} && echo "Granting access..."
echo "GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION" | mysql -u root --password=${mysql_pass}

# Restore Database from dump
/bin/bash scripts/mysql-restore.sh $mysql_db $mysql_pass

# Download and extract Craft
wget -qO craft.tar.gz http://download.buildwithcraft.com/craft/${craft_version}/${craft_version}.${craft_build}/Craft-${craft_version}.${craft_build}.tar.gz && echo "Downloading Craft-${craft_version}.${craft_build}.tar.gz..."
tar -zxf craft.tar.gz
rm craft.tar.gz

# Remove old files
echo "Removing old files..."
rm /var/www/html/.htaccess
rm -r craft/config && rm -r craft/plugins && rm -r craft/templates
rsync -r --ignore-existing craft /var/www && rsync -a public/ /var/www/html/
rm /var/www/html/.htaccess 2> /dev/null
mv /var/www/html/htaccess /var/www/html/.htaccess
rm -r craft && rm -r public && rm -r /var/www/html/web.config && rm -r /var/www/html/index.html 2> /dev/null
#Give craft writing permission for the storage folder
chmod 777 /var/www/craft/storage

# AllowOverride
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
a2enmod rewrite > /dev/null && echo "Enablind module rewrite..."

# Install Mcrypt
apt-get -y install mcrypt php5-mcrypt > /dev/null && echo "Installing MCrypt..."
php5enmod mcrypt

# Install ImageMagick
apt-get -y install imagemagick php5-imagick > /dev/null && echo "Installing Imagick..."

# Restart Services
echo "Restarting Services..."
service apache2 restart > /dev/null
service mysql restart > /dev/null
