# 기본 이미지로 Debian Buster를 사용
FROM debian:buster

# 필요한 패키지 설치 (Nginx, OpenSSL, wget, PHP, MariaDB Client)
RUN apt-get update && apt-get install -y nginx openssl wget php-fpm php-mysql

# SSL 인증서 및 키 파일 생성
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=42Seoul/CN=localhost"

# NGINX 설정 파일 복사
COPY ./conf/default.conf /etc/nginx/sites-available/default

# WordPress 다운로드 및 압축 해제
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xzvf latest.tar.gz -C /var/www/html/ \
    && rm latest.tar.gz

# 권한 설정
RUN chown -R www-data:www-data /var/www/html/wordpress \
    && chmod -R 755 /var/www/html/wordpress

# PHP-FPM 소켓 파일의 위치와 권한 설정
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# 포트 80 (HTTP)과 443 (HTTPS) 노출
EXPOSE 80 443

# PHP-FPM과 Nginx를 동시에 실행
CMD service php7.3-fpm start && nginx -g "daemon off;"
