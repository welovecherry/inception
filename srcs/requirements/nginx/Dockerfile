# latest Debian image: bookworm, second latest: bullseye
# FROM debian:bullseye

# -nginx: web server to handle HTTP/HTTPS requests
# -openssl: generate SSL certificates
# -clean up the apt cache to reduce the image size
# RUN apt-get update -y && \
#     apt-get install -y nginx openssl && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the script to the container's root directory
# entry point: script.sh
# COPY ./tools/script.sh /script.sh

# RUN chmod +x /script.sh

# EXPOSE 443

# when a container is started from this image, the script will be executed
# CMD ["/script.sh"]


# latest Debian image: bookworm, second latest: bullseye
FROM debian:bullseye

# -nginx: web server to handle HTTP/HTTPS requests
# -openssl: generate SSL certificates
# -clean up the apt cache to reduce the image size
RUN apt-get update -y && \
    apt-get install -y nginx openssl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the script to the container's root directory
COPY ./tools/script.sh /script.sh

# Make sure the script is executable
RUN chmod +x /script.sh

# Expose port 443 for HTTPS
EXPOSE 443

# Set script.sh as the entrypoint to be executed when the container starts
ENTRYPOINT ["/script.sh"]
