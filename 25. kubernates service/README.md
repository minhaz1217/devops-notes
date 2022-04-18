# Purpose
Here we deploy 3 nginx pods and a service that load balances between these 3 pods.

Services are used to make a single, constant point of entry to a group of pods providing the same service. Services has a fixed ip and port that never changes while the service exists.

## Usage
### At first bring up all the pods using
```
kubectl create -f pod1.yaml
kubectl create -f pod2.yaml
kubectl create -f pod3.yaml
```

### Get pods
`kubectl get pods -L service`

Notice that 2 of the pods have `service` label set to `backend` this is what we use to select these pods for our service.

### Create service
`kubectl create -f service.yaml`

### Get service using
`kubectl get service`

`kubectl get svc`

Notice the cluster ip, this is the ip we can use to get to the service from inside the cluster.

### Describe the service using
`kubectl describe service backend-service`

Notice the `Endpoints`, these are the ips of the pods this service is connected to.

### We can get ip of the pods that the service is managing using
`kubectl get endpoints backend-service`

`kubectl get ep backend-service`


### Now lets make a request to the service from inside a pod using the cluster ip 
`kubectl exec <pod_name> -- curl -s <cluster_ip>`

`kubectl exec simple-dotnet-1 -- curl -s http://10.110.95.47`

Execute this command multiple time and see that the container is responding differently each time. This is because our service is loadbalancing between the pods on its own.

### Get service related environment variable from inside the pod using
`kubectl exec simple-dotnet-1 -- env`

#### See only the backend-service's information
`kubectl exec simple-dotnet-1 -- bash -c "env | grep BACKEND"`

## Discovering service via DNS
### See the `resolv.conf` to get FQDN of the cluster the pod belongs to.
`kubectl exec simple-dotnet-1 -- cat /etc/resolv.conf`

### So we can access our service from inside the cluster using these FQDN.
Full FQDN: 

`kubectl exec simple-dotnet-1 -- curl -s http://backend-service.default.svc.cluster.local`

Partial FQDN: 

`kubectl exec simple-dotnet-1 -- curl -s http://backend-service.default`

Using service name: 

`kubectl exec simple-dotnet-1 -- curl -s http://backend-service`
