# Purpose
Try the service type loadbalancer.

# Basics

### Run the service using
`kubectl create -f loadbalancer-svc.yaml`

### Create replication controller for pods using
`kubectl create -f server-rc.yaml`

### See that the replication controller is up
`kubectl get rc`

### See that the pods are up
`kubectl get pods -o wide`

### See that the service is up using, notice your external ip. This is the ip that we'll be using to contact with the pods.
`kubectl get svc`

### See that the service is redirecting to the pods using
`kubectl get ep`

### Send request to the server through service using
`curl localhost:3001`
