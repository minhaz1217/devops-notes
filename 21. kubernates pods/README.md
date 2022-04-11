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

### See logs of previously crashed pod
`kubectl logs <pod_name> --previous`

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

### Add label to a node
`kubectl label node <node_name> gpu=true`

### Verify that the node with gpu map and true value is there
`kubectl get nodes -l gpu=true`

### Now we can bind our pod to this node
`kubectl create -f '.\bind pod to a nod.yaml'`

warning: if the pod doesn't find any node that matches the specified binding, it won't be up.

### Adding and modifying annotations
`kubectl annotate pod <pod_name> minhazul.com/someannotation="annotation value"`

## Namespace

### Get list of namespaces
`kubectl get ns`

### Get pod in that namespace
`kubectl get pod -n <namespace_name>`

`kubectl get pod --namespace <namespace_name>`

### Create a namespace
`kubectl create -f basic_namespace.yaml`

`kubectl create namespace api`

### Create a pod in a namespace
`kubectl create -f pod.yaml -n api`

## Deleting

### Deleting a pod
`kubectl delete pod <pod_name>`

`kubectl delete pod --all`

### Delete pod with label selector
`kubectl delete pod -l env=testing`

### Delete a namespace
`kubectl delete ns api`

### Delete namespace and everything on it
`kubectl delete all --all`

## Liveness Probe
Liveness probe makes request to a given endpoint and after multiple failure automatically restarts the container.

### Run a pod using 
`kubectl create -f liveliness-probe.yaml`

This pod crashes after 5 hit to the / endpoint. 

### Use this to see that the liveness probe failed
`kubectl describe pod liveness`

### After some time run this
`kubectl logs liveness --previous`


