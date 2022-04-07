# Purpose
Here we will build a layer 7 loadbalancer using nginx and use 3 python servers in a single pod.

## Build all the images using
```
docker build -t minhaz1217/i_23_loadbalancer loadbalancer
docker build -t minhaz1217/i_23_microservice1 microservice1
docker build -t minhaz1217/i_23_microservice2 microservice2
docker build -t minhaz1217/i_23_microservice3 microservice3
```
## Push all the images using
```
docker push minhaz1217/i_23_loadbalancer
docker push minhaz1217/i_23_microservice1
docker push minhaz1217/i_23_microservice2
docker push minhaz1217/i_23_microservice3
```

## Run the pod using
`kubectl apply -f layer7 load balancing.yaml`

## Run this command to verify that all the containers are up
`kubectl get pods`

## Forward the load balancer port to main host machine using
`kubectl port-forward layer-7-load-balancing 3001:80`

## Now curl multiple time to reach the backend
`curl localhost:3001`

Watch the output and see that different microservice is getting the call

## Now use the endpoint to get result out from redis
`curl localhost:3001/get-hit-count`