# Architecture
![communication between microservices and load balancer architecture](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/16.%20docker%20compose%20communicating%20microservice/image/loadbalancer%20and%20microservice%20communication.png)

## Run the docker-compose using
`docker-compose build`

`docker-compose up`

## Check that it is working by using
`curl localhost:3000`

## To communicate between 2 microservices do
`curl localhost:3000/get-hit-count`