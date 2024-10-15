#!/bin/bash

# Start MariaDB service
# initialize the MariaDB server
service mysql start

# Wait for MariaDB to start up
sleep 10

# Use provided environment variables to configure database
# this script creates a temporary SQL file to create a database and user
cat <<EOF > /init-db.sql
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' 
IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* 
TO '${MYSQL_USER}'@'%';

FLUSH PRIVILEGES;
EOF

# Apply SQL script to MariaDB
mysql < /init-db.sql

# Stop MariaDB service before running it in the foreground
service mysql stop

# Run MariaDB in the foreground
mysqld_safe
