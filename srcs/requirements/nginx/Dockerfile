# 기본 이미지로 Debian Buster 사용
FROM debian:buster

# 필요한 패키지 설치 (Nginx, OpenSSL, wget, PHP, MariaDB)
RUN apt-get update && apt-get install -y nginx openssl wget php-fpm php-mysql mariadb-server

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

# wp-config.php 파일 자동 생성 및 데이터베이스 설정
RUN cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php && \
    sed -i "s/database_name_here/wordpress/" /var/www/html/wordpress/wp-config.php && \
    sed -i "s/username_here/wpuser/" /var/www/html/wordpress/wp-config.php && \
    sed -i "s/password_here/password/" /var/www/html/wordpress/wp-config.php && \
    sed -i "s/localhost/localhost/" /var/www/html/wordpress/wp-config.php

# 권한 설정
RUN chown -R www-data:www-data /var/www/html/wordpress \
    && chmod -R 755 /var/www/html/wordpress

# PHP-FPM 소켓 파일의 위치와 권한 설정
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# MariaDB 데이터베이스 초기화 및 사용자 설정
RUN service mysql start && \
    mysql -e "CREATE DATABASE wordpress;" && \
    mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'password';" && \
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';" && \
    mysql -e "FLUSH PRIVILEGES;"

# 포트 80 (HTTP)과 443 (HTTPS) 노출
EXPOSE 80 443

# MariaDB, PHP-FPM, Nginx를 동시에 실행
CMD service mysql start && service php7.3-fpm start && nginx -g "daemon off;"

# cherrylove