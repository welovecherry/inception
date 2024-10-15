#!/bin/bash

# Generate a self-signed SSL certificate for HTTPS connections
# -x509: Create a self-signed certificate
# -nodes: Do not encrypt the private key
# -newkey rsa:2048: Generate a new RSA key of 2048 bits
# -keyout: Output the private key to the specified file

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out $CERTS_ \
    -subj "/C=KR/L=Seoul/O=42/OU=student/CN=jungmiho.42.fr"

# Remove the default Nginx server block configuration
# prevent conflicts by ensuring only the custom configuration is used
rm -f /etc/nginx/sites-enabled/default

# Create a new Nginx server block configuration for HTTPS connections
echo "server {
    # listen from IPv4 
    listen 443 ssl;
    # listen from IPv6
    listen [::]:443 ssl;

    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    ssl_protocols TLSv1.3 TLSv1.2;

    index index.php;
    root /var/www/html;

    # configure PHP processing using FastCGI
    # -tries to serve the requested file or return a 404 error
    location ~ [^/]\.php(/|$) {
        try_files \$uri =404;
        fastcgi_pass wordpress:9000;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }
}" > /etc/nginx/sites-available/default

# Create a symbolic link to enable the new server block configuration
ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

# Test Nginx configuration for syntax errors
nginx -t

# start Nginx in the foreground
# -g "daemon off;": Run Nginx in the foreground
nginx -g "daemon off;"