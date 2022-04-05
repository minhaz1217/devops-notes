# Purpose
Deploy kubernates dashboard and connect to it.


## First download and apply this
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.5.0/aio/deploy/recommended.yaml`

## Create the admin user first and then apply
`kubectl apply -f service-user.yaml`

## Then try to create a role binding with the admin using this
`kubectl apply -f cluster-role-binding.yaml`

## Start the server by using
`kubectl proxy`

## To access the server go here.
[http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy)

## Use this to generate token
`kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"`