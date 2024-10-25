#!/bin/bash

# Ensure the script exits on first error
set -e

echo "Creating directory structure for WordPress..."
mkdir -p /var/www/html

cd /var/www/html

echo "Cleaning existing files for a fresh WordPress installation..."
rm -rf *

echo "Downloading WP CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar
echo "Set WP CLI executable."
mv wp-cli.phar /usr/local/bin/wp
echo "Moved WP CLI to PATH."

echo "Downloading WordPress..."
wp core download --allow-root

if [ -f /wp-config.php ]; then
    echo "Moving wp-config.php to the WordPress directory..."
    mv /wp-config.php .
else
    echo "wp-config.php does not exist, please ensure it's correctly placed."
    exit 1
fi

echo "Setting database connection details in wp-config.php..."
sed -i -r "s/database_name_here/${WORDPRESS_DB_NAME}/" wp-config.php
sed -i -r "s/username_here/${WORDPRESS_DB_USER}/" wp-config.php
sed -i -r "s/password_here/${WORDPRESS_DB_PASSWORD}/" wp-config.php
sed -i -r "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php

# Diagnostic information
echo "Database Host: ${WORDPRESS_DB_HOST}"
echo "Database User: ${WORDPRESS_DB_USER}"
[ -z "${WORDPRESS_DB_PASSWORD}" ] && echo "Database Password is not set." || echo "Database Password is set."

echo "Checking direct database connectivity..."
until mysql -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e ';' ; do
    echo "Waiting for direct database connection..."
    sleep 5
done
echo "Direct database connectivity confirmed."

echo "Verifying database readiness with WP CLI..."
until wp db check --path=/var/www/html --allow-root >/dev/null 2>&1; do
    echo "Retrying WP CLI database connection..."
    sleep 5
    done
echo "Database connection established with WP CLI."

# echo "Installing WordPress..."
wp core install --url="${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_USR}" --admin_password="${WP_ADMIN_PWD}" --admin_email="${WP_ADMIN_EMAIL}" --skip-email --allow-root
echo "WordPress installation complete."

# Check and create/update a new WordPress user with the details from environment variables
if [[ -n "${WP_USR}" && -n "${WP_PWD}" && -n "${WP_EMAIL}" ]]; then
    echo "Checking if WordPress user exists..."
    if ! wp user get "${WP_USR}" --field=login --path=/var/www/html --allow-root >/dev/null 2>&1; then
        echo "Creating WordPress user..."
        wp user create "${WP_USR}" "${WP_EMAIL}" --user_pass="${WP_PWD}" --role=author --path=/var/www/html --allow-root
        echo "WordPress user created."
    else
        echo "User '${WP_USR}' already exists. Skipping creation."
        # Optional: Update existing user details here
        # wp user update "${WP_USR}" --user_pass="${WP_PWD}" --user_email="${WP_EMAIL}" --path=/var/www/html --allow-root
        # echo "Existing WordPress user '${WP_USR}' updated."
    fi
else
    echo "WordPress user details are not set. Skipping user creation."
fi

# Ensure the /run/php directory exists for the PHP-FPM PID file
echo "Ensuring /run/php directory exists..."
mkdir -p /run/php

# Change PHP-FPM to listen on TCP port 9000
echo "Configuring PHP-FPM to listen on TCP port 9000..."
sed -i 's/^listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf

# Ensure the script does not exit in case the database is not immediately ready
set +e

echo "Starting PHP-FPM..."
exec php-fpm7.3 -F