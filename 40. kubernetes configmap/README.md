# Purpose
Exploring configmap on kubernetes


## Basics
### There are different ways to set values with config map
1. Literal `--from-literal=foo=bar`
2. From file - All `--from-file=bar=foobar.conf`
3. From file - Selective `--from-file=bar=foobar`
4. From file - Directory `--from-file=config-dir/`



#### Create config map for values
`kubectl create configmap foo-config --from-literal=foo=bar`

#### To see config map use
`kubectl get cm`

#### See details about config mg
`kubectl describe cm`

#### Get config from config map created from file
`kubectl get configmap my-config -o yaml`


#### Create configmap from file
`kubectl create configmap my-config --from-file=prod.env`

#### Edit a configmap using
`kubectl edit configmap my-config`


#### Creating configmap from yaml file
`kubectl create -f basic_config_map.yaml`

#### Delete configmap
`kubectl delete cm basic-configmap`

## Configmap as environment variable

#### At first create the CM using
`kubectl create configmap basic-configmap --from-file=prod.env`


#### Go into the pod using
`kubectl exec -it environment-from-configmap -- bash`

#### Enter this and verify that it is working
`env | grep -i sleep`