# -f: file location
# -d: detached mode, run in background (to use terminal)

all : up

up : 
	docker compose -f ./srcs/docker-compose.yml up -d
down : 
	docker compose -f ./srcs/docker-compose.yml down
down_volume : 
	docker compose -f ./srcs/docker-compose.yml down -v
logs : 
	docker compose -f ./srcs/docker-compose.yml logs
remove-images :
	docker rmi $(docker images -q)
clean : down rm remove-images 