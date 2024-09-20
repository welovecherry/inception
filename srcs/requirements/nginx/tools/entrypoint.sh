# 컨테이너가 시작될 때 실행되는 스크립트

#!/bin/bash
# 스크립트 실행 중 오류 발생 시 스크립트 종료
set -e

# 로그 파일 설정
LOG_FILE="/var/log/entrypoint.log"

# 로그 함수 정의
log() {
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $1" | tee -a $LOG_FILE
}

# 서비스 시작
log "Starting services..."
service mysql start
service php7.3-fpm start

# PHP-FPM은 이미 실행 중이므로 별도로 시작할 필요 없음

# MySQL이 준비될 때까지 대기
log "Waiting for MySQL to be ready..."
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done
log "MySQL is ready."

# 데이터베이스 초기화 확인
if [ ! -d /var/lib/mysql/wordpress ]; then
    log "Initializing database..."
    mysql -e "CREATE DATABASE wordpress;" \
        && log "Database 'wordpress' created."
    mysql -e "CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'password';" \
        && log "User 'wpuser' created."
    mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';" \
        && log "Privileges granted to 'wpuser'."
    mysql -e "FLUSH PRIVILEGES;" \
        && log "Privileges flushed."
fi

# WordPress 설정 확인
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    log "Configuring WordPress..."
    wp core config \
        --path=/var/www/html/wordpress \
        --dbname=wordpress \
        --dbuser=wpuser \
        --dbpass=password \
        --dbhost=localhost \
        --allow-root \
        && log "wp-config.php created."

    log "Installing WordPress..."
    wp core install \
        --path=/var/www/html/wordpress \
        --url="https://localhost" \
        --title="My WordPress Site" \
        --admin_user="book" \
        --admin_password="book" \
        --admin_email="book@example.com" \
        --skip-email \
        --allow-root \
        && log "WordPress installed."

    log "Creating additional user..."
    wp user create cherry cherry@example.com \
        --role=author \
        --user_pass="cherry" \
        --path=/var/www/html/wordpress \
        --allow-root \
        && log "User 'cherry' created."
fi

# 권한 설정
log "Setting permissions..."
chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

# Nginx를 포그라운드에서 실행하여 컨테이너가 종료되지 않도록 함
log "Starting Nginx..."
nginx -g "daemon off;"
