# Purpose
The purpose of this note is to get up and running with kubernates using k3s. Lunch an app using replication controller and communicate with it using a service.

# Setup k3s
## Install k3s using
`curl -sfL https://get.k3s.io | sh -`

## Change to root user to use all commands easily
`sudo su`

## Check that the installation was successful
`k3s kubectl get node`

## See cluster info using this
`kubectl cluster-info`

## Get node information
`kubectl get nodes`

## Get pods information
`kubectl get pods`

## Get service information
`kubectl get services`

## Describe node
`kubectl describe node <node name>`

<!-- ## To install bash completion use
`apt-get install bash-completion -y`

## run this
`echo 'source <(kubectl completion bash)' >>~/.bashrc` -->

# Launch and expose a pod
## Run a container using
`kubectl run nginx --image=nginx`

## See the status of that container using
`kubectl get pods`

## Describe the nginx pod using
`kubectl describe pod nginx`

## Expose the pod with a service using
`kubectl expose pods nginx --type=LoadBalancer --name nginx-http2 --port 80`

## Check that the service is running
`kubectl get services`

![kubectl get services output](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/19.%20kubernates%20deploying%20app/images/kubectl%20get%20services.png)
Note the external ip of nginx-http2

## Now use curl to verify that it is working
`curl localhost:80`


# Using replication controller
`kubectl expose rc nginx --type=LoadBalancer --name nginx-http`

kubectl create service clusterip my-svc --clusterip="None" -o yaml --dry-run=client > srv.yaml
kubectl create --edit -f srv.yaml

kubectl run curl --image=nginx-service:curl -i --tty

`kubectl expose rc nginx --type=LoadBalancer --name nginx-http`

`kubectl get replicationcontrollers`

`kubectl scale rc nginx --replicas=1`

`kubectl get pods -o wide`

`kubectl describe pod nginx-td7cf`

`sudo kubectl version --client`

`kubectl cluster-info dump`
