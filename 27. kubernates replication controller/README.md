# Purpose
Replication controller manages the pods and it's replication. We give the replication controller a `label selector`, a `pod template` and a `replica count`, the replication controller manages the pod and makes sure the correct number of replica is always running. So in case where a pod crashes the RC will make sure that the pod has the correct number of replicas again.

Here I document basic usage of kubernates replication controller.


## Replication controller basics

### Three important things that replication controller uses to do its job
1. A `label selector`
2. A `replica count`
3. A `pod template`

### Use this to create a replication controller
`kubectl create -f basic-replicaton-controller.yaml`

### See the replication controller using
`kubectl get rc`

### Use this to get pods
`kubectl get pod`

### Delete a pod using
`kubectl delete pod <pod_name>`

### See how replication controller's desired and current and ready column changes
`kubectl get rc`

### Use this to see details about the rc
`kubectl describe rc nginx-rc`

### We can edit the RC using this
`kubectl edit rc nginx-rc`

## Horizontally scaling pods
### Use this to change the number of replicas a RC manages
`kubectl scale rc nginx-rc --replicas=5`

### Verify that the change is working by using
`kubectl get rc`

### Using the same approach we can downscale the RC as well.
`kubectl scale rc nginx-rc --replicas=2`

## Deleting
### Deleting the RC and all its pods
`kubectl delete rc nginx-rc`

### To keep the pod but deleting the RC use this
`kubectl delete rc nginx-rc --cascade=false`