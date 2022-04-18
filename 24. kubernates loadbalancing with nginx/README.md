# Purpose
We will be loadbalancing the entry point to our application. This application consists of 2 microservices that communicates between each other via http and uses redis as a database. The first microservice only send a request to the second microservice and the second microservice communicated with redis and send the first microservice the data. We put a nginx load balancing in front of the first microservice to expose it to our client.

# Architecture
![communication between microservices and load balancer architecture](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/16.%20docker%20compose%20communicating%20microservice/image/loadbalancer%20and%20microservice%20communication.png)

## First build the first microservice using
`docker build -t minhaz1217/i_23_microservice1 microservice1`

## Then build the second microservice using
`docker build -t minhaz1217/i_23_microservice2 microservice2`

## After that build the loadbalancer with the config in it microservice using
`docker build -t minhaz1217/i_23_loadbalancing_2_microservices loadbalancer`

## Login to docker
`docker login`

## Set the repository you want the images to push to
`docker push minhaz1217/devops-notes`

## Push the built images
```
docker push minhaz1217/i_23_microservice1
docker push minhaz1217/i_23_microservice2
docker push minhaz1217/i_23_loadbalancing_2_microservices
```