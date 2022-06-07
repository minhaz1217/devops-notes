# Purpose
To explore kubernetes secrets

# Basics
#### Create a secret using this
`kubectl create secret generic fortune-https --from-file=foo`

#### See what's inside the secret using
`kubectl get secret fortune-https -o yaml`

#### Describe secret using
`kubectl describe secrets fortune-https`

<!-- ### Create secret from file
`kubectl create -f basic_secret.yaml` -->

#### Deleting secrets
`kubectl delete secrets fortune-https`

## Pulling image from private docker registry 

#### Setup docker registry email and passwords
`kubectl create secret docker-registry mydockerhubsecret --docker-username=myusername --docker-password=mypassword --docker-email=my.email@provider.com`

Here keep in mind that we are create a docker-registry type secret

#### Use the secret in a pod's definition
`kubectl create -f pull_image_from_private_registry.yaml`

