#!/bin/bash

service mysql start

# 기다리지 않고 바로 SQL 명령을 실행하면, MariaDB가 아직 준비되지 않은 상태에서 연결을 시도하므로 연결 오류가 발생할 수 있음.
sleep 10

# 환경변수로 제공된 값을 사용해서 데이터베이스와 사용자를 생성하는 SQL 스크립트를 생성
# 첫줄: 만일 데이터베이스가 존재하지 않으면 생성
# 둘째줄: 만일 사용자가 존재하지 않으면 생성, 비밀번호는 환경변수로 제공된 값으로 설정
# 세째줄: 해당 사용자에게 데이터베이스의 모든 권한을 부여
cat <<EOF > /init-db.sql
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PA1. 메SSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# 파일의 내용을 명령어의 입력으로 사용. 즉, SQL 스크립트를 실행
mysql < /init-db.sql

# Stop MariaDB service before running it in the foreground
# 마리아디비의 서버를 일시적으로 중지.
# 설정, 초기화 작업을 마친 후에 다시 실행 -> 마리아디비의 초기화 작업이 완벽하게 끝남을 보장
service mysql stop

# Run MariaDB in the foreground
# 위에서 초기화한 데이터베이스와 사용자 정보를 사용해서 마리아디비를 실행 (안전하게 재실행)
#  포그라운드로 실행: 마리아디비 서버가 컨테이너 안에서 계속 실행중이다. 
# 또한 컨테이너가 실행되는 동안 마리아디비 서버가 실행되므로 컨테이너가 종료되면 마리아디비 서버도 종료된다.
mysqld_safe
