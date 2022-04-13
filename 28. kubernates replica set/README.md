# Purpose
Here we discuss about replica set and its usage. Replica sets does the same thing as replication controller, but does something even more. For example.

Replication controller can select one label at a time, like env=prod or env=dev

Replica set select both label at the same time.

Replication controller can't select pot that has any value, replica set can (like env=*)

## Basics of replicaset
### Create a replicaset using
`kubectl create -f basic_replicaset.yaml`

### Verify that the replicaset is working by running
`kubectl get replicaset`

`kubectl get rs`

### We can get more information about replica set using
`kubectl describe rs`

`kubectl describe rs <replicaset_name>`

### We can use the match expression as label selector
`kubectl create -f replicaset_match_expression.yaml`


## Scaling
### We can use the same scaling as replicaset
`kubectl scale rs nginx --replicas=5`

## Deleting
### Deleting the RS and all its pods
`kubectl delete rs nginx`

### To keep the pod but deleting the RS use this
`kubectl delete rs nginx --cascade=orphan`