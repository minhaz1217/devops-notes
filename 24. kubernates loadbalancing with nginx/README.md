# Purpose
Here we will be load balancing to two difference services using FQDN and using nginx to load balance between the 2 services.

# Architecture

![Load balance between services using nginx architecture](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/01_load%20balancing%20with%20kubernates%20and%20nginx.png)

# Steps
### First we bring up the two servers using replication controller
```
kubectl create -f server1-rc.yaml
kubectl create -f server2-rc.yaml
```

### Check that the replication controllers are up using
`kubectl get rc`

![replication controllers](https://github.com/minhaz1217/devops-notes/blob/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/02_replication%20controllers%20are%20up.png?raw=true)

### See that the pods are up using
`kubectl get pods -o wide -L app`

![server pods](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/03_all%20the%20server%20pods%20are%20up.png)


### Start the services for these pods
```
kubectl create -f server1-svc.yaml
kubectl create -f server2-svc.yaml
```
### Check that the services are up using
`kubectl get svc`

![server services](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/04_all%20the%20server%20services%20are%20up.png)

### Make sure that the services are managing our pods using
`kubectl get ep`

![server endpoints](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/05.%20investigate%20endpoints.png)

### Create the replication controller for the nginx loadbalancer
`kubectl create -f loadbalancer-rc.yaml`

### Create the service for the loadbalancer
`kubectl create -f loadbalancer-svc.yaml`

### See all the pods using
`kubectl get pods -o wide -L app`

![all pods are up](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/06_all%20pods%20are%20up.png)

### See that all the services are up and connected to the pods
`kubectl get ep`

![all endpoints](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/07_all%20endpoints.png)

### Get services using
`kubectl get svc`

![all services](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/08_all%20services.png)

Note the `External-IP`.

### Now send request to the external-ip and see that the request is being loadbalanced
`curl localhost:3001`

#### To loop use this in powershell
for (($i = 0); $i -lt 10; $i++){ 
    curl.exe localhost:3001
    "" 
}

![load balancer correctly redirecting](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/24.%20kubernates%20loadbalancing%20with%20nginx/images/09_load%20balancing%20working.png)


## Delete everything we've done so far (restore your kubectl to just like before we started)
```
kubectl delete rc server1-rc
kubectl delete rc server2-rc
kubectl delete rc loadbalancer-rc
kubectl delete svc server1-svc
kubectl delete svc server2-svc
kubectl delete svc loadbalancer-svc
```
