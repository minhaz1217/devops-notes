# Purpose
Here we will be load balancing to two difference services using FQDN and using nginx to load balance between the 2 services.

# Architecture
![Load balance between services using nginx](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx%5Cimages%5Cload%20balancing%20with%20kubernates%20and%20nginx.png)

# Steps
### First we bring up the two servers using replication controller
```
kubectl create -f server1-rc.yaml
kubectl create -f server2-rc.yaml
```

### Check that the replication controllers are up using
`kubectl get rc`

### See that the pods are up using
`kubectl get pods -o wide -L app`

### Start the services for these pods
```
kubectl create -f server1-svc.yaml
kubectl create -f server2-svc.yaml
```
### Check that the services are up using
`kubectl get svc`

### Make sure that the services are managing our pods using
`kubectl get ep`

### Create the replication controller for the nginx loadbalancer
`kubectl create -f loadbalancer-rc.yaml`

### Create the service for the loadbalancer
`kubectl create -f loadbalancer-svc.yaml`

### See all the pods using
`kubectl get pods -o wide -L app`

### See that all the services are up and connected to the pods
`kubectl get ep`

### Get services using
`kubectl get svc`

Note the `External-IP`.

### Now send request to the external-ip and see that the request is being loadbalanced
`curl localhost:3001`

