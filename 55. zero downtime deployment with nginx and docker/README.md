# Zero Downtime Deployment with Nginx and Docker
## Purpose
I wanted to try out zero downtime deployment otherwise the blue-green deployment. This will help me understand how to do very basic no downtime deployment when using nginx as reverse proxy and basic docker containers as my deployed app.

## TL;DR Steps
* Start a container that is our v1.
* Configure nginx to route traffic to that container using proxy pass and check that it is working.
* Start another container that is our v2.
* Configure nginx to route traffic to the v2 container and mark the v1 container as down.
* Test and verify that during the switch our existing connection to the v1 didn't drop.
* Remove the v1 entry from the nginx configuration.
* To edit the nginx configuration I use a #placeholder in the config.

## Steps
### We need to make an entry in the `hosts` file so that our traffic in `zero-downtime.local` is routed to the nginx. So edit the file `/etc/hosts`(for linux) or `C:\Windows\System32\drivers\etc\hosts` (for windows) and enter this
```
127.0.0.1 zero-downtime.local
```

### Create a network to try out this
```
docker network create zero-downtime
```

### Start a nginx docker
```
docker run -dit -p80:80 --network zero-downtime --name nginx-zero-downtime nginx
```
### Now we'll copy the nginx config.
```
docker cp ./zero-downtime.conf nginx-zero-downtime:/etc/nginx/conf.d
```

### Start up the container that we want to route traffic to (later we'll mark it blue when we start another container)
```
docker run -dit --name basic-api-1 --network zero-downtime minhaz1217/basic_go_api:v1
```

### Get the current latest container id and replace the string inside the conf file
```
service_name=basic-api
current_container_id=$(docker ps -f name=$service_name -q | tail -n1)
docker exec -it nginx-zero-downtime  sed -i "s/#placeholder/server $current_container_id:3000;\n#placeholder/g" /etc/nginx/conf.d/zero-downtime.conf
```
### (Optional) Now if we query for the container id and look inside the zero-downtime.conf file we'll see that the container id is there.
```
docker ps --filter "name=basic-api-1"

docker exec -it nginx-zero-downtime cat /etc/nginx/conf.d/zero-downtime.conf
```

### Now we'll check that our nginx config is correct
```
docker exec -it nginx-zero-downtime nginx -t
```

### If it says `syntax is ok` and `test is successful` then we'll reload the nginx
```
docker exec -it nginx-zero-downtime nginx -s reload
```

### Now we will hit the `zero-downtime.local` endpoint and make sure that it is working
```
curl zero-downtime.local
```
It should return the container id.

### Now we will create another container.
```
docker run -dit --name basic-api-2 --network zero-downtime minhaz1217/basic_go_api:v2
```

### We'll change nginx config so that it will route to the new container along with the old container
```
service_name=basic-api

new_container_id=$(docker ps -f name=$service_name -q | head -n1)

docker exec -it nginx-zero-downtime  sed -i "s/#placeholder/server $new_container_id:3000;\n#placeholder/g" /etc/nginx/conf.d/zero-downtime.conf
```

### Now we'll check that our nginx config is correct
```
docker exec -it nginx-zero-downtime nginx -t
```

### If it says `syntax is ok` and `test is successful` then we'll reload the nginx
```
docker exec -it nginx-zero-downtime nginx -s reload
```

### Now we'll send multiple curl request and see that both of the container is being routed to.
```
for i in {1..10}
do
    curl zero-downtime.local
done
```
We can see that both v1 and v2 is being routed to.

### Now we'll mark the v1 as down.
```
service_name=basic-api
old_container_id=$(docker ps -f name=$service_name -q | tail -n1)
docker exec -it nginx-zero-downtime  sed -i "s/server $old_container_id:3000;/server $old_container_id:3000 down;/g" /etc/nginx/conf.d/zero-downtime.conf

```
### We can inspect the config file and we'll see that the old container id has down beside it. As a result nginx won't route to this container.
```
docker exec -it nginx-zero-downtime cat /etc/nginx/conf.d/zero-downtime.conf
```

### Now we'll check that our nginx config is correct
```
docker exec -it nginx-zero-downtime nginx -t
```

### After the reload even before the delay calls are successful if we request the domain. We'll see that it is sending request to only v2.
```
for i in {1..10}
do
    curl zero-downtime.local
done
```

### Now before we apply the new config, we'll run multiple curl request that will take ~30 seconds to complete and then we'll apply the config. If we are successful then the request that are on going won't be affected but all new request will be going to the new container.
```
curl zero-downtime.local/delay/60000
```
This endpoint output result after a delay. We are setting the delay to 1 min.

### Now we'll reload the nginx config
```
docker exec -it nginx-zero-downtime nginx -s reload
```

### Now we can just remove the old entry from our config file
```
docker exec -it nginx-zero-downtime  sed -i "/server $old_container_id:3000 down;/d" /etc/nginx/conf.d/zero-downtime.conf
```

### If we inspect the config we'll see that that line with server marked down is gone
```
docker exec -it nginx-zero-downtime cat /etc/nginx/conf.d/zero-downtime.conf
```

### Now we'll check and reload the nginx config for the last time.
```
docker exec -it nginx-zero-downtime nginx -t
docker exec -it nginx-zero-downtime nginx -s reload
```
### Now we can stop the old container.
```
docker stop $old_container_id
docker rm $old_container_id
```


### Once the system is up and running the whole process of marking the old container as down and entering the new container id can be done with a single script.
```
service_name=basic-api
old_container_id=$(docker ps -f name=$service_name -q | tail -n1)
new_container_id=$(docker ps -f name=$service_name -q | head -n1)
docker exec -it nginx-zero-downtime  sed -i "s/#placeholder/server $new_container_id:3000;\n#placeholder/g" /etc/nginx/conf.d/zero-downtime.conf
docker exec -it nginx-zero-downtime  sed -i "s/server $old_container_id:3000;/server $old_container_id:3000 down;/g" /etc/nginx/conf.d/zero-downtime.conf
docker exec -it nginx-zero-downtime nginx -t
docker exec -it nginx-zero-downtime nginx -s reload
```
Remember to trigger this only after the new container is up and running.

### And the process of removing the old container and reloading nginx
```
service_name=basic-api
old_container_id=$(docker ps -f name=$service_name -q | tail -n1)
docker exec -it nginx-zero-downtime  sed -i "/server $old_container_id:3000 down;/d" /etc/nginx/conf.d/zero-downtime.conf
docker exec -it nginx-zero-downtime nginx -t
docker exec -it nginx-zero-downtime nginx -s reload
docker stop $old_container_id
docker rm $old_container_id
```

## My Setup
For this I'm using a windows machine. All my commands are run in WSL. Here are the docker versions
```
Client: Docker Engine - Community   - Version: 20.10.14
Server: Docker Desktop - Engine     - Version: 20.10.21
```