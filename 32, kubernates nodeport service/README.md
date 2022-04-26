# Purpose
Here we'll be experimenting with kubernates nodeport type service. 

Node port open a port directly to the node the pod is running in.

# Basics

### Create the node port service
`kubectl create -f nodeport-svc.yaml`

### See that the nodeport is up
`kubectl get svc`

### See more information about the service using
`kubectl describe nodeport-svc`

### Now we run a daemon set. It creates pod on selected nodes
`kubectl create -f daemonset.yaml`

### See the pods that there is no pod because we'll need to label our nodes if we want our pods to get started on them
`kubectl get pods`

### Get the nodes using
`kubectl get nodes -L disk`

### Label the nodes appropriately.
`kubectl label node docker-desktop disk=ssd --overwrite`

### Now see that there are some pods
`kubectl get pods`

### Get your cluster ip using
`kubectl get node -o wide`

### We can access our app using 
`curl <cluster_internal_ip>:30123`

![node port working](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/35.%20setup%20a%20kubernetes%20cluster/images/cluster%20lb%20working%20using%20nodeport.png)