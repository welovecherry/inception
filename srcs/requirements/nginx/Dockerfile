# Use Debian Buster as the base image for compatibility and stability
FROM debian:buster

# Update package list and install Nginx and OpenSSL
# Nginx is used as the web server
# OpenSSL is used to generate a self-signed SSL certificate for HTTPS
RUN apt-get update -y && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the startup script into the container
# This script will generate an SSL certificate and configure Nginx
COPY ./tools/script.sh /script.sh

# Make sure the script is executable
RUN chmod +x /script.sh

# Expose port 443 for HTTPS traffic
EXPOSE 443

# Set the CMD to your startup script
# This script configures and starts Nginx with the generated SSL certificate
CMD ["/script.sh"]
