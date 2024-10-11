# 가장 최신 버전: Debian 12(Bookworm), 두번째 최신 버전: Debian 11(Bullseye)
# 컨테이너가 실행될 기본 운영체제 환경 설정
FROM debian:bullseye

# Update package list and install Nginx and OpenSSL
# Nginx is used as the web server
# OpenSSL is used to generate a self-signed SSL certificate for HTTPS
# OpenSSL: HTTPS를 위한 자체 서명 SSL 인증서 생성
# 설치 후, 사용하지 않는 패키지를 삭제하고, 캐시를 삭제하여 이미지 크기를 줄임
RUN apt-get update -y && \
    apt-get install -y nginx openssl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the startup script into the container
# This script will generate an SSL certificate and configure Nginx
# 로컬에 있는 script.sh 스크립트 파일을 컨테이너로 복사
# 이 스크립트는 SSL 인증서 생성 및 Nginx 설정하는 스크립트
COPY ./tools/script.sh /script.sh

# Make sure the script is executable
RUN chmod +x /script.sh

# Expose port 443 for HTTPS traffic
EXPOSE 443

# Set the CMD to your startup script
# This script configures and starts Nginx with the generated SSL certificate
CMD ["/script.sh"]
