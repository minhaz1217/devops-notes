# Purpose
Here we forward traffic from outside our cluster into our cluster using Layer 4 proxy, then inside our cluster we setup Layer 7 proxy and forward our traffic to appropriate service.

# Architecture
This is what we will be implementing.
<!-- TODO: add image -->

# Setup
## In the main PC, if in a test environment
### Config the hosts file to redirect request to the vagrant box
`nano /etc/hosts`

### Add these lines at the end of the file.
```
10.10.10.100 api.payment.foodpanda.com
10.10.10.100 api.order.foodpanda.com
```

## Outside the cluster server
### Here we setup our layer 4 proxy outside our cluster
### (Optional) Bring up a separate machine using vagrant
`vagrant up`

### Login to the vagrant box and setup the layer 4 proxy
`vagrant ssh`

### At first install nginx using
`sudo apt install nginx -y`

### Copy the contents of the `layer-4 load balancer/nginx.conf` config to this file
`nano /etc/nginx/nginx.conf`

### Check that the configuration is ok using
`sudo nginx -t`

### Now restart the nginx using
`sudo systemctl restart nginx`


## In the cluster

### Brining up the order service and pod from `order service` folder
`cd "order service"`
### To first we create replica set
`kubectl create -f order-rs.yaml`

### Check that the replica set and pods are up using
`kubectl get rs`

`kubectl get pods`

### The replica set has scale of 1, so that the pod can start quickly, when it starts we scale it to 3
`kubectl scale rs rs-order-service --replicas=3`

<!-- TODO: insert image -->

### Start the order service using
`kubectl create -f order-svc.yaml`

### Make sure the that service is up using
`kubectl get svc`


### Brining up the payment service and pod from `payment service` folder
`cd "payment service"`
### To first we create replica set
`kubectl create -f payment-rs.yaml`

### Check that the replica set and pods are up using
`kubectl get rs`

`kubectl get pods`

### The replica set has scale of 1, so that the pod can start quickly, when it starts we scale it to 3
`kubectl scale rs rs-payment-service --replicas=3`


### Start the order service using
`kubectl create -f payment-svc.yaml`

### Make sure the that service is up using
`kubectl get svc`

<!-- TODO: insert image 03 -->

### Here we will configure layer 7 proxy along with the services and pods.

### At first start the layer 7 proxy pods (these are built using the dockerfile from `layer-7 load balancer`) 
`cd "load balancer service"`

### Start the replica set
`kubectl create -f load-balancer-rs.yaml`

### Start the pods using
`kubectl create -f load-balancer-svc.yaml`

### Make sure the the rs, pods and services are up using
`kubectl get rs,pods,svc`

<!-- TODO: image -->

### Now from outside the server curl to the services using (where we've changed the hosts file.)
`curl api.order.foodpanda.com`

`curl api.payment.foodpanda.com`

<!-- for (($i = 0); $i -lt 10; $i++){ 
    curl.exe api.order.foodpanda.com
    "" 
}

for (($i = 0); $i -lt 10; $i++){ 
    curl.exe api.payment.foodpanda.com
    "" 
} -->

<!-- TODO: add image -->


## Delete everything
### To remove everything we've created in here use this
```
kubectl delete rs load-balancer
kubectl delete rs rs-order-service
kubectl delete rs rs-payment-service
kubectl delete svc load-balancer-service
kubectl delete svc order-service
kubectl delete svc payment-service
```