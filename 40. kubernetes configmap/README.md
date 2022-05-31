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

`kubectl create configmap my-config --from-file=prod.env`