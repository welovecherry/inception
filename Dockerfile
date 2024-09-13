FROM debian:buster

# 필요한 패키지 설치 및 SSL 설정
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && mkdir -p /etc/nginx/ssl \
    && openssl req -x509 -nodes -sha256 \
        -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=42Seoul/CN=login.42.fr"

# conf 디렉토리의 내용을 NGINX 설정 디렉토리로 복사
COPY ./conf/ /etc/nginx/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]