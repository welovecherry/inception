all : up

up : 
	docker-compose -f ./srcs/docker-compose.yml up -d
down : 
	docker-compose -f ./srcs/docker-compose.yml down
rm : 
	docker-compose -f ./srcs/docker-compose.yml down -v
ps : 
	docker-compose -f ./srcs/docker-compose.yml ps
logs : 
	docker-compose -f ./srcs/docker-compose.yml logs
