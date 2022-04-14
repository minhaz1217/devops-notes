# Purpose
Here we discuss and use kubernates daemonset.

Daemonset is used to run a pod on **selected nodes**.

## Basics
### List your `ssd` labeled  nodes using
`kubectl get nodes -L disk`

### If no nodes are marked as `ssd` we can mark a node ssd using this
`kubectl label node <node_name> disk=ssd`

### Start the daemon set
`kubectl create -f basic_daemonset.yaml`

### See the daemonset using
`kubectl get ds`

`kubectl get daemonset`

### We can see information about the daemonset using
`kubectl describe daemonset <daetmonset_name>`

### Verify that the pod is up using
`kubectl get pods`

### Now we change a node's disk label using
`kubectl label node <node_name> disk=ssd2 --overwrite`

### Now verify that the pod is gone using
`kubectl get pods`