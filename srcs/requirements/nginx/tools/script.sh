#!/bin/bash

# Generate a self-signed SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out $CERTS_ \
    -subj "/C=KR/L=Seoul/O=42/OU=student/CN=jungmiho.42.fr"

# Ensure the nginx default site is disabled first to prevent symlink error
rm -f /etc/nginx/sites-enabled/default

# Create a new Nginx server block configuration
echo "server {
    listen 443 ssl;
    listen [::]:443 ssl;

    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    ssl_protocols TLSv1.3;

    index index.php;
    root /var/www/html;

    location ~ [^/]\.php(/|$) {
        try_files \$uri =404;
        fastcgi_pass wordpress:9000;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}" > /etc/nginx/sites-available/default

# No need to append additional configuration as the server block is complete
# The initial 'echo' command now fully configures the Nginx server block

# Ensure the Nginx configuration is symlinked correctly
ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Test Nginx configuration for syntax errors
nginx -t

# Ensure Nginx is configured to start without daemonizing
nginx -g "daemon off;"
