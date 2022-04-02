# Purpose
The purpose of this note is to get up and running with kubernates using k3s. Lunch an app using replication controller and communicate with it using a service.

# Setup k3s
## Install k3s using
`curl -sfL https://get.k3s.io | sh -`

## Change to root user to use all commands easily
`sudo su`

## Check that the installation was successful
`k3s kubectl get node`

## Get kubernates client version
`kubectl version --client`

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

## To get all the information
`kubectl cluster-info dump`

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

### To reset kubectl, delete all the things we've done so far use this
```
kubectl delete service nginx-http2

kubectl delete pod nginx
```

# Using replication controller

## Download the replication controller config file
`wget https://raw.githubusercontent.com/minhaz1217/devops-notes/master/19.%20kubernates%20deploying%20app/nginx-replication-controller.yaml`

## Run this to create the replication controller
`kubectl create -f nginx-replication-controller.yaml`

## To see the replication controller use this
`kubectl get rc`

## Use this to see the pods
`kubectl get pods`

## Delete one of the pods an see that the replication controller will spin up another
`kubectl delete pod nginx-<custom key>`

`kubectl get pods`

## Create a service to access the replication controller
`kubectl expose rc nginx --type=LoadBalancer --name nginx-http`

## Use this and get the external ip of the service
`kubectl get service`

## Curl to the external ip
`curl localhost`

## Now we scale down the replicas
`kubectl scale rc nginx --replicas=1`

## Watch that the pods have been scaled down
`kubectl get pods`

## Now we scale up the replicas
`kubectl scale rc nginx --replicas=5`

## Watch that the pods have been created
`kubectl get pods -o wide`

## Curl to the external ip again
`curl localhost`
