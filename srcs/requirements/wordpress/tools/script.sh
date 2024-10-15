#!/bin/bash

# Exit the script immediately if any command fails
set -e

#  1: Create directory structure for WordPress installation
mkdir -p /var/www/html

cd /var/www/html  # Navigate to the WordPress directory

rm -rf *  

#  3: Download WP CLI (WordPress Command Line Interface)
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

#  4: Set WP CLI as an executable and move it to a directory in the PATH
chmod +x wp-cli.phar  
mv wp-cli.phar /usr/local/bin/wp 

#  5: Download WordPress core files using WP CLI
wp core download --allow-root 

#  6: Check for existing wp-config.php file and move it to the WordPress directory
if [ -f /wp-config.php ]; then
    mv /wp-config.php .  
else
    exit 1  
fi

#  7: Configure database connection details in wp-config.php
sed -i -r "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php  # Set the database name
sed -i -r "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php  # Set the database username
sed -i -r "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php  # Set the database password
sed -i -r "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php  # Set the database host

#  8: Verify direct connection to the MariaDB database
until mysql -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e ';' ; do
    sleep 5  
done

#  9: Verify database readiness using WP CLI
until wp db check --path=/var/www/html --allow-root >/dev/null 2>&1; do
    sleep 5 
done

#  10: Install WordPress using WP CLI
wp core install --url="${DOMAIN_NAME}" \
                --title="${WP_TITLE}" \
                --admin_user="${WP_ADMIN_USR}" \
                --admin_password="${WP_ADMIN_PWD}" \
                --admin_email="${WP_ADMIN_EMAIL}" \
                --skip-email --allow-root

#  11: Check if the WordPress user exists and create one if not
if [[ -n "${WP_USR}" && -n "${WP_PWD}" && -n "${WP_EMAIL}" ]]; then
    if ! wp user get "${WP_USR}" --field=login --path=/var/www/html --allow-root >/dev/null 2>&1; then
        wp user create "${WP_USR}" "${WP_EMAIL}" --user_pass="${WP_PWD}" --role=author --path=/var/www/html --allow-root  # Create a new user
    fi
fi

#  12: Ensure the PHP directory exists for the PHP-FPM process
mkdir -p /run/php 

#  13: Configure PHP-FPM to listen on TCP port 9000 instead of a Unix socket
sed -i 's/^listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf 

set +e

#  15: Start the PHP-FPM service in the foreground
exec php-fpm7.3 -F
