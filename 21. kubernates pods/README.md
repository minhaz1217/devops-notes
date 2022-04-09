# Purpose
Here we explore different things that we can do with kubernates pods.

Containers inside a pod share same namespace, so they share ip addresses and ports. They can access each other via localhost port binding.

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

`kubectl get pods -o yaml` - output in yaml format


`kubectl port-forward nginx-redis 8080:80`

`kubectl get pods -l env=production`

`kubectl get po -l '!env'`

`kubectl label node docker-desktop gpu=true`

`kubectl create namespace api`

`kubectl get pods -n api`