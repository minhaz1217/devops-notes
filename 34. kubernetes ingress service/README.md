# Purpose
Here we learn how to use ingress to route traffic to our app.

# Prerequisites
## Installing ingress controller
### At first make sure that ingress controller is running in your kubernetes cluster
`kubectl get pod --all-namespaces | grep ingress`

If there is a ingress controller you can skip these steps

### If there is no ingress controller pod running we can install nginx ingress controller using this
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.0/deploy/static/provider/cloud/deploy.yaml`

### See that the pods are running using
`kubectl get pods --namespace=ingress-nginx`

### Additionally we can wait for the pod to be up using
```
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=500s
```

## Making sure the ingress controller setup is working

### Create a demo server
```
kubectl create deployment ingress-controller-demo --image=httpd --port=80
kubectl expose deployment ingress-controller-demo
```

### Expose that server through ingress
```
kubectl create ingress ingress-controller-demo-ing --class=nginx --rule=demo.localdev.me/*=ingress-controller-demo:80
```

### Now portforward the server to ingress
`kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80`

### Now curl from the master node
`curl demo.localdev.me:8080`

If everything is ok you'll see output as `<html><body><h1>It works!</h1></body></html>`
![curl output](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/34.%20kubernetes%20ingress%20service/images/01.%20ingress%20controller%20setup%20is%20working.png)

### Delete everything that was used for testing
```
kubectl delete ingress ingress-controller-demo-ing
kubectl delete deployment ingress-controller-demo --cascade
kubectl delete pods ingress-controller-demo
kubectl delete svc ingress-controller-demo
```

## Deploying our own service and route with ingress
### Cd into the simple dotnet service
`cd "simple dotnet service"`

### create the Service and the replication controller
```
kubectl create -f dotnet-rs.yaml
kubectl create -f dotnet-svc.yaml
```

### Cd into the order service and create the replication controller and the service
```
cd "order service"
kubectl create -f order-rs.yaml
kubectl create -f order-svc.yaml
```

### Now go to the main folder and create the ingress service
`cd ..`

`kubectl create -f basic_ingress.yaml`

### We can get ingress using
`kubectl get ing`

`kubectl get ingress`

### We can see information using 
`kubectl describe ing`
See that there is an event to sync with nginx controller

### Now port forward the ingress controller to 8080
`kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80`


### Make some request and verify that ingress is handling the traffic
`curl order.foodpanda.com:8080`

`curl simple-dotnet.example.com:8080`
# Reference
[https://kubernetes.github.io/ingress-nginx/deploy/](https://kubernetes.github.io/ingress-nginx/deploy/)

[https://kubernetes.io/docs/concepts/services-networking/ingress/](https://kubernetes.io/docs/concepts/services-networking/ingress/)


#
# Created By - [Minhazul Hayat Khan](https://github.com/minhaz1217)
