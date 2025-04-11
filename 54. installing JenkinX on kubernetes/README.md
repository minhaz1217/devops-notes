# Purpose

Just installing JenkinX workflow with minikube in windows

# Steps

# Important
```
JenkinX support kubernetes version 1.24 only, so don't use different version.
```

### Start minikube cluster
```
minikube start --cpus 4 --memory 6048 --disk-size=100g --addons=ingress --kubernetes-version=1.24.14

minikube kubectl -- get pods -A
```

## Installing the cli

### Install the jx cli from [here](https://github.com/jenkins-x/jx/releases/download/v3.10.83/jx-windows-amd64.zip)
```
https://github.com/jenkins-x/jx/releases/download/v3.10.83/jx-windows-amd64.zip
```

### Try it out using 
```
jx version

or 

jx --help 
```


## Add the cluster config repo

### Create a git repo with [this](https://github.com/jx3-gitops-repositories/jx3-minikube/generate) template

```
https://github.com/jx3-gitops-repositories/jx3-minikube/generate
```
<!-- 
### Add your domain in the `jx-requirements.yml` file in the created github

Change
```
cluster:
---
ingress:
  domain: ""

```

To this
```
ingress:
  domain: "yourdomain.com"
```

### Verify that the server doesn't have nginx installed.

```
kubectl get ns
kubectl get node
``` -->

## Install and configure git operator

### Create a git [token](https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,admin:repo_hook,write:packages,read:packages,write:discussion,workflow) 
```
https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,admin:repo_hook,write:packages,read:packages,write:discussion,workflow
```
### Clone the config git repo
```
git clone <your_repo_url>

cd <your_repo_name>
```

### Point the minikube ip to ingress
```
$DOMAIN="$(minikube ip).nip.io"
jx gitops requirements edit --domain $DOMAIN
```
### Start ngrok if needed
```
ngrok http 8080
```

### Change the file `charts/jenkins-x/jxboot-helmfile-resources/values.yaml` and the domain you got form ngrok
```
ingress:
  customHosts:
    hook: "<your_domain>"

```

### Installing jx 3.x CLI
```
curl -L https://github.com/jenkins-x/jx/releases/download/v3.10.83/jx-linux-amd64.tar.gz | tar xzv
chmod +x jx 
sudo mv jx /usr/local/bin
```


### Install the [operator](https://jenkins-x.io/v3/admin/setup/operator/)
```

$GIT_REPO="https://github.com/minhaz1217/oms-jx3-kubernetes.git"
$GIT_USER="<you_git_username>"
$GIT_TOKEN="<your_git_token>"

jx admin operator --username $GIT_USER --token $GIT_TOKEN


helm repo add jxgh https://jenkins-x-charts.github.io/repo
helm repo add jx3 https://jenkins-x-charts.github.io/repo
helm repo add jxgo https://jenkins-x-charts.github.io/repo

helm repo update

$GIT_REPO="https://github.com/minhaz1217/oms-jx3-kubernetes.git"
$GIT_USER="minhaz1217"
$GIT_TOKEN="<git_token>"

jx admin operator --username $GIT_USER --token $GIT_TOKEN

helm search repo jx-git-operator

helm upgrade --install \
    --set url=$GIT_URL \
    --set username=$GIT_USER \
    --set password=$GIT_TOKEN \
    jx-git-operator --create-namespace jxgo jx3/jx-git-operator
```


jx admin operator --username $GIT_USER --token $GIT_TOKEN


helm upgrade --install --set url=$GIT_URL --set username=$GIT_USER --set password=$GIT_TOKEN jx-git-operator --create-namespace jxgh/jx-git-operator



If this fail another way to install
```
helm upgrade --install \
        --set url=$GIT_URL \
        --set username=$GIT_USER \
        --set password=$GIT_TOKEN \
         jx-git-operator --create-namespace jxgo ./
```
helm upgrade --install --set url=https://github.com/minhaz1217/oms-jx3-kubernetes.git --set username=minhaz1217 --set password=<git_token> --create-namespace jx-git-operator jxgo jx3/jx-git-operator

helm upgrade --install --set url=https://github.com/minhaz1217/oms-jx3-kubernetes.git --set username=minhaz1217 --set password=<git_token> jx-git-operator --create-namespace  ./ jxgo
