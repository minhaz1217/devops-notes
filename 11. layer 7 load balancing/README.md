# Layer 7 load balancing,
## We will be load balancing between 2 servers using nginx.
### For our application server we'll be using the default nginx server

![Architecture](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/11.%20layer%207%20load%20balancing/images/layer%207%20load%20balancer.drawio.png)

## Run a application server using
`docker run -dit --name server1 nginx`


## Run another application server using
`docker run -dit --name server2 nginx`

## Inspect docker to find the ip of this 2 container using
`docker network inspect bridge`

## Note the IP of this 2 containers.

![Ip address of the servers](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/11.%20layer%207%20load%20balancing/images/ip_of_the_servers.png)


## Another way to find the ips of the servers is this
`docker inspect server1`

![IP of server1](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/11.%20layer%207%20load%20balancing/images/server1_ip.png)

`docker inspect server2`

![IP of server2](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/11.%20layer%207%20load%20balancing/images/server2_ip.png)

## Now go to `nginx.conf`
`nano nginx.conf`

## Add the ip addresses like this
```
upstream loadbalancer{
    server 172.17.0.2:80 weight=5;
    server 172.17.0.3:80 weight=5;
}
```

## Now build and run the loadbalancer by using
`docker build -t i_loadbalancer .`

`docker run -p 80:80 --name loadbalancer -dit i_loadbalancer`


## To see that our loadbalancer is working perfectly we connect to the logs of `loadbalancer`, `server1` and `server2`
`docker logs -f loadbalancer`

`docker logs -f server1`

`docker logs -f server2`

## Now send request to localhost using curl
`curl localhost`

![The requests are being load balanced](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/11.%20layer%207%20load%20balancing/images/loadbalancer_balancing_requests.png)

## In the image we can see that the load balancer is sending request to the 2 servers properly.
