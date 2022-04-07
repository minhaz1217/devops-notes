# Purpose
Here we will build a layer 7 loadbalancer using nginx and use 3 python servers in a single pod.

We are trying to simulate this architecture

![layer 7 load balancing inside a single pod](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/23.%20kubernates%20layer%207%20load%20balancing%20with%20nginx/images/layer%207%20load%20balancing%20inside%20a%20pod.png)

!! WARNING !! - This way of architecturing this many containers inside a single pod is **bad**. We are doing it like this just for **demonstration**.

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