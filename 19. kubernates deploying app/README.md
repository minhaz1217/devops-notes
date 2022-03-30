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

## To install bash completion use
`apt-get install bash-completion -y`

## run this
`echo 'source <(kubectl completion bash)' >>~/.bashrc`


## Run a container using
`kubectl run nginx --image=nginx`

## See the status of that container using
`kubectl get pods`

`kubectl describe pod nginx`

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
