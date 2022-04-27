# Purpose
Here we'll be experimenting with kubernates nodeport type service. 

Node port open a port directly to the node the pod is running in.

# Basics

### Create the node port service
`kubectl create -f nodeport-svc.yaml`

### See that the nodeport is up
`kubectl get svc`

![service are up](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/32%2C%20kubernates%20nodeport%20service/images/01.%20services%20are%20up.png)
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
![pods on each node is up](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/32%2C%20kubernates%20nodeport%20service/images/02.%20pods%20are%20up%20in%20each%20nodes.png)

### Get your cluster ip using
`kubectl get node -o wide`

### We can access our app using 
`curl <cluster_public_ip>:30123`

![node port working](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/32%2C%20kubernates%20nodeport%20service/images/03%20nodeport%20service%20working.png)