# Purpose
Here we deploy 3 nginx pods and a service that load balances between these 3 pods.

## Usage
### At first bring up all the pods using
```
kubectl create -f pod1.yaml
kubectl create -f pod2.yaml
kubectl create -f pod3.yaml
```

### Get pods
`kubectl get pods -F service`

Notice that all the pods have `service` label set to `nginx` this is what we use to select these pods for our service

### Create service
`kubectl create -f service.yaml`

### Get service using
`kubectl get service`