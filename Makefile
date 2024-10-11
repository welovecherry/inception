# all : up

# up : 
# 	docker-compose -f ./srcs/docker-compose.yml up -d
# down : 
# 	docker-compose -f ./srcs/docker-compose.yml down
# rm : 
# 	docker-compose -f ./srcs/docker-compose.yml down -v
# ps : 
# 	docker-compose -f ./srcs/docker-compose.yml ps
# logs : 
# 	docker-compose -f ./srcs/docker-compose.yml logs

all: up
# "all"이라는 목표(target)는 "up" 명령어를 실행. 이 파일을 실행할 때 기본적으로 "up" 명령을 실행하는 역할을 함.

up:
docker-compose -f ./srcs/docker-compose.yml up -d
# -f 옵션을 사용하여 특정 경로에 있는 docker-compose.yml 파일을 지정합니다.
# 여기서 -f ./srcs/docker-compose.yml 은 srcs 디렉토리에 있는 docker-compose.yml 파일을 사용하도록 지정합니다.
# "up" 명령어는 정의된 모든 서비스를 시작하고, -d 옵션은 이를 백그라운드에서 실행하도록 합니다.

down:
docker-compose -f ./srcs/docker-compose.yml down
# -f 옵션으로 특정 경로의 docker-compose.yml 파일을 지정합니다.
# "down" 명령어는 모든 실행 중인 서비스를 중지하고, 네트워크와 관련된 모든 리소스를 삭제합니다.

rm:
docker-compose -f ./srcs/docker-compose.yml down -v
# -v 옵션을 추가하여 모든 볼륨을 제거합니다.
# 이는 서비스가 중지될 때 컨테이너와 함께 생성된 데이터 볼륨까지 삭제하여 초기 상태를 유지하게 합니다.

ps:
docker-compose -f ./srcs/docker-compose.yml ps
# 현재 실행 중이거나 정의된 컨테이너들의 상태를 확인합니다.
# -f 옵션으로 특정 docker-compose.yml 파일을 지정합니다.

logs:
docker-compose -f ./srcs/docker-compose.yml logs
# docker-compose logs 명령어는 실행 중인 컨테이너들의 로그를 확인할 수 있게 합니다. (디버깅)
# 특정 파일의 docker-compose 설정을 기반으로 로그를 출력합니다.