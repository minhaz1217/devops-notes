# Purpose
Here we explore different things that we can do with kubernates pods.

Containers inside a pod share same namespace, so they share ip addresses and ports. They can access each other via localhost port binding.
## Get information about a pod
### Get all the pods
`kubectl get pods`

### Get specific pod
`kubectl get pod <pod_name>`

### Get help about pods
`kubectl explain pods`

### Get details about a pod
`kubectl describe pod <pod_name>`

### Get different output for pods
`kubectl get pods -o wide` - shows ips and other things

`kubectl get pods -o json` - output in json format

`kubectl get pods -o json`

`kubectl get pods -o yaml` - output in yaml format

## Logs of a pod

### See logs
`kubectl logs <pod_name>` - See log of a pod if it has one container

`kubectl logs <pod_name> <container_name>` - See logs if the pod has multiple container

### Send traffic to a pod
`kubectl port-forward nginx 8080:80`

## Labels

### See labels of a pod
`kubectl get pod --show-labels`

### See the labels in column
`kubectl get pods -L app,backend`

### Filter by label
`kubectl get pods -l app,service`

### Adding labels to existing pods
`kubectl label pod <pod_name> app=microservice1`

### Modifying existing labels
`kubectl label pod <pod_name> env=debug --overwrite`

### Filter by existing label key and value
`kubectl get pod -l env=debug`

### Filter by existing label key
`kubectl get pod -l env`

### Filter by pod that **doesn't** have that label
`kubectl get pod -l '!env'`



`kubectl label node docker-desktop gpu=true`

`kubectl create namespace api`

`kubectl get pods -n api`