#!/bin/bash

# Set passwords
mysql_root_password="<your_mysql_root_password>"
wordpress_user_password="<your_wordpress_user_password>"

# Update system
apt update
apt upgrade -y

# Install Apache, MySQL, PHP, and other necessary packages
apt install -y apache2 mysql-server php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip unzip

# Start Apache and MySQL services
systemctl start apache2
systemctl start mysql

# Enable Apache and MySQL to start on boot
systemctl enable apache2
systemctl enable mysql

# Secure MySQL installation
mysql_secure_installation <<EOF

y
$mysql_root_password
$mysql_root_password
y
y
y
y
EOF

# Download and set up WordPress
cd /tmp
curl -LO https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php

# Generate unique keys and salts
curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> /tmp/wordpress/wp-config.php

# Create WordPress database and user
mysql -u root -p"$mysql_root_password" <<MYSQL_SCRIPT
CREATE DATABASE wordpress;
CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '$wordpress_user_password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';
FLUSH PRIVILEGES;
EXIT
MYSQL_SCRIPT

# Remove the default Apache index.html file
rm /var/www/html/index.html

# Configure Apache for WordPress
cp -r /tmp/wordpress/. /var/www/html/
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Restart Apache
systemctl restart apache2

# Clean up
rm -rf /tmp/wordpress

echo "WordPress installation is complete."
