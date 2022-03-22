

## Install docker and docker compose

```

sudo apt-get update

sudo apt-get install ca-certificates curl gnupg lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

docker-compose --version
```

## Create a docker-compose.yml file
`nano docker-compose.yml`

## Paste these into docker-compose.yml
```
version: "3.9"
services:
  web1:
    image: "nginx"
  web2:
    image: "nginx"
  redis:
    image: "redis:alpine"
```


## Run the compose file using
`docker-compose up`
 
 or

`docker-compose up -d`

## Check that the containers are up using

`sudo docker ps`
