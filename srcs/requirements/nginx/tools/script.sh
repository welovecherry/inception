#!/bin/bash

# Generate a self-signed SSL certificate
# OpenSSL을 사용해 자체 서명된 SSL 인증서를 생성합니다.
# -x509 : X.509 인증서를 생성합니다.
# 365 : 인증서의 유효기간을 365일로 설정합니다.
# -newkey rsa:2048 : RSA 알고리즘과 2048비트의 키를 생성합니다.
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out $CERTS_ \
    -subj "/C=KR/L=Seoul/O=42/OU=student/CN=jungmiho.42.fr"

# Ensure the nginx default site is disabled first to prevent symlink error
# 엔진엑스 기본 사이트가 심볼릭 링크 오류를 방지하도록 먼저 비활성화되었는지 확인합니다.
rm -f /etc/nginx/sites-enabled/default

# Create a new Nginx server block configuration
# 엔진엑스 서버 블록: 웝서버가 특정 도메인이나 경로에 대한 요청을 처리하는 방법을 정의합니다.
echo "server {
    listen 443 ssl;
    listen [::]:443 ssl;

    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

    ssl_protocols TLSv1.2 TLSv1.3;

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
# Nginx가 백그라운드로 실행되지 않고 포그라운드에서 실행되도록 설정합니다.
# - Docker 컨테이너가 종료되지 않도록 하기 위해 Nginx를 데몬 모드가 아닌 포그라운드에서 실행합니다.
nginx -g "daemon off;"
