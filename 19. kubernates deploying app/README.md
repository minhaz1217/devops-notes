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

## Describe node
`kubectl describe node <node name>`