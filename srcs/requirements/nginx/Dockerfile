# 기본 이미지로 Debian Buster 사용
FROM debian:buster

# 필요한 패키지 설치
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    wget \
    curl \
    mariadb-server \
    php-fpm \
    php-mysql \
    php-cli \
    php-mbstring \
    php-xml \
    php-zip \
    php-gd \
    php-curl \
    php-pear \
    php-bcmath \
    php-imagick \
    php-redis \
    php-intl \
    && apt-get clean

# PHP Phar 확장 모듈 활성화
RUN phpenmod phar

# PHP 설정에서 phar.readonly를 Off로 설정
RUN echo "phar.readonly = Off" >> /etc/php/7.3/cli/php.ini && \
    echo "phar.readonly = Off" >> /etc/php/7.3/fpm/php.ini

# WP-CLI 설치
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp-cli.phar \
    && ln -s /usr/local/bin/wp-cli.phar /usr/local/bin/wp

# WP-CLI가 올바르게 설치되었는지 확인
RUN wp --info --allow-root

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

# PHP-FPM 소켓 파일의 위치와 권한 설정
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# 엔트리포인트 스크립트 복사 및 실행 권한 부여
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 포트 노출
EXPOSE 80 443

# 엔트리포인트 스크립트 실행
CMD ["/entrypoint.sh"]
