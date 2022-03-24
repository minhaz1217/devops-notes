## Install docker and docker compose
```
wget https://raw.githubusercontent.com/minhaz1217/linux-configurations/master/bash/03.%20installing%20docker/install_docker_and_docker_compose.sh

bash install_docker_and_docker_compose.sh
```

## Create 2 servers and make a Dockerfile on each of them
```bat
mkdir microservice1
mkdir microservice2
```

## Create Dockerfile for server1
`nano microservice1/Dockerfile`

## Paste these
```docker
FROM nginx:alpine
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```


## Create Dockerfile for server2
`nano microservice2/Dockerfile`

## Paste these
```docker
FROM nginx:alpine
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### We are simulating building 2 micro services that we will build from Dockerfile using a single docker compose file.

## Create the docker-compose.yml
`nano docker-compose.yml`

## Paste these
```yml
version: "3.9"
services:
  microservice1:
    container_name: microservice1
    build: microservice1
    networks:
      - multiple_microservices

  microservice2:
    container_name: microservice2
    build: microservice2
    networks:
      - multiple_microservices

  redis:
    container_name: redis
    image: "redis:alpine"
    networks:
      - multiple_microservices
networks:
  multiple_microservices:
    name: multiple_microservices
```

## Run the docker compose using
`sudo docker-compose up -d`

### These microservices can communicate between each other using their names. We can test it.

## In a console follow logs of one container
`sudo docker logs -f microservice2`


## Now exec into the other container with another console.
`sudo docker exec -it microservice1 sh`

## Now curl to the other microservice via it's container name
`curl microservice2`

### You can see the output into the console that is following the other microservice