#!/bin/bash

# Start MariaDB service
service mysql start

# Wait for MariaDB to start up
sleep 10

# Use provided environment variables to configure database
cat <<EOF > /init-db.sql
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Apply SQL script
mysql < /init-db.sql

# Stop MariaDB service before running it in the foreground
service mysql stop

# Run MariaDB in the foreground
mysqld_safe
