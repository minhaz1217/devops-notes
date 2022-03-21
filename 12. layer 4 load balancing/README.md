## Run 3 servers using
```
docker run -dit --name server1 nginx
docker run -dit --name server2 nginx
docker run -dit --name server3 nginx
```

## Now to verify that the servers are receiving hit, we follow the logs of those servers
```
docker logs -f server1
docker logs -f server2
docker logs -f server3
```


## Inspect the servers and find out the ips
```
docker inspect server1
docker inspect server2
docker inspect server3
```

## In my case the ips are 
```
172.17.0.2
172.17.0.3
172.17.0.4
```

### Edit the `/loadbalancer/layer4_loadbalancing.conf` file to enter your ips

## Build the loadbalancer in the loadbalancer folder
`docker build -t i_layer4_loadbalancer .`

## Run the docker container
`docker run -dit --name loadbalancer i_layer4_loadbalancer`

## Exec into the container
`docker exec -it loadbalancer sh`

## Install curl
`apt update & apt install curl -y`

## Curl to localhost 3000
`curl localhost:3000`

## Watch that the loadbalancer is balancing load in the logs of the servers

## References
https://github.com/tekn0ir/nginx-stream

https://nginx.org/en/docs/stream/ngx_stream_core_module.html

https://facsiaginsa.com/nginx/configure-nginx-as-layer-4-load-balancer