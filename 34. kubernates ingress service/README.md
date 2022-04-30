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
kubectl create ingress demo-localhost --class=nginx \
  --rule=demo.localdev.me/*=ingress-controller-demo:80
```

### Now portforward the server to ingress
`kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80`

### Now curl from the master node
`curl demo.localdev.me:8080`

If everything is ok you'll see output as `<html><body><h1>It works!</h1></body></html>`

# Reference
[https://kubernetes.github.io/ingress-nginx/deploy/](https://kubernetes.github.io/ingress-nginx/deploy/)