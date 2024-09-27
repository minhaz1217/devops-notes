# Purpose
Automatically deploy an application using argo cd.

# Steps
## Install argo cd
### Run these in kubernetes master node
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

### Expose argo cd api. 
```
kubectl patch svc argocd-server -n argocd -p '{\"spec\": {\"type\": \"LoadBalancer\"}}'
```

### See that the service is up and notice the port
```
kubectl get svc -n argocd
```
<!-- `kubectl port-forward svc/argocd-server -n argocd 3005:443` -->


### Or forward the port to access argo cd
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

### Login using the CLI
```
argocd admin initial-password -n argocd
```

The user is `admin` and the password is the generated password

### Go to the argocd dashboard using the masternode's ip
`<master_node_ip>:31917`


### Use this to generate the admin password
`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

Login through the dashboard using the username `admin` and the generated password


#
# Created By - [Minhazul Hayat Khan](https://github.com/minhaz1217)
