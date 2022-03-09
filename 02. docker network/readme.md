
# At first run 
`ifconfig`

# If not found install ifconfig by
`sudo apt install net-tools`
### Notice there is only one interface that is `eth0` 

# Now Install docker
```
sudo apt-get update

sudo apt-get install ca-certificates curl gnupg lsb-release -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```
`sudo apt install docker`

### Again run `ifconfig` notice there is a new interface `docker0`. This has ip of 172.17.0.1 and network mask of 255.255.0.0

# List docker network by running
`sudo docker network ls`

# We can inspect a network by 
`sudo docker network inspect bridge`

### Notice the *container* in the output is empty and the bridge name is *docker0*.


# Run a container
`sudo docker run -d -p 80:80 --name nginx nginx`

# Check running containers by
`sudo docker ps`

# Now enter the public ip address of the server and see that nginx server is running.

### Enter `ifconfig` and notice that there is a new interface `veth` that only has *ipv6* address 

# Now run the network inpect again
`sudo docker network inspect bridge`

### Notice that the *Containers* as our nginx running with ipaddress `172.17.0.2`

# Stop the nginx container by running
`sudo docker stop nginx`

### Now run the `ifconfig` again and notice that the `veth` is gone. Through this interface traffice passes in the container.

# Run the nginx container again by
`sudo docker start nginx`

# Go inside the nginx container by
`sudo docker exec -it nginx bash`

# Inside the container run
`apt-get update`

### Now inside the container run `ifconfig`, notice that there is a interface `eth0` with ip `172.17.0.2`

# Install tcpdum by
`apt-get install tcpdump -y`

# To check for traffic run tcpdump from inside the container with 
`tcpdump -i eth0`

# Now open a new bash to the host computer and ping inside the container
`ping 172.17.0.2`

### Notice that from inside the container we are detecting this ping

# Now from a browser hit the public ip of the host pc.
### Notice that we are detecting the hits from inside the container


# To get a better understanding of the network traffic.
![Docker bridge network traffic flow](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/images/how_bridge_network_works.png "Docker bridge network traffic flow").

## Open 2 shells from the host pc and run
`sudo tcpdump -i eth0 | grep HTTP`

`sudo tcpdump -i docker0 | grep HTTP`

## From inside the container run
`sudo tcpdump -i eth0 | grep HTTP`

### Now from the browser hit the public ip of the machine.
### Notice that the traffic goes from the eth0 > docker0 > eth0 of the container.

## Now stop all the tcpdumps by pressing `ctrl + c`
## Again open 2 shells from the host pc and run
`sudo tcpdump -i eth0 | grep ICMP`

`sudo tcpdump -i docker0 | grep ICMP`

## From inside the container run
`sudo tcpdump -i eth0 | grep ICMP`

### Now from your personal computer ping the public ip of the host machine `ping <public ip>`. Notice that the ICMP requests are only hitting the *eth0* of the host machine and not the *docker0* of host or *eth0* of container.

# Run in the host machine 
`arp`
### Notice that there is an entry for docker0 notice the HWAddress. 
## Now run
`sudo docker network inspect bride`

### Notice that the `MacAddress` of the nginx container matches with the arp `HWAddress`.

## Run another docker container
`sudo docker run -d -p 81:80 --name nginx2 nginx`

## Inspect network by
`sudo docker network inspect bridge`

### Notice that the new nginx2's ip is `172.17.0.3` 

## In the host machine run 
`ifconfig` 
### Notice that there is a new veth interface
### Run `arp` notice there is a new entry for `docker0`
### Again the HWAddress from the new entry matches with the MAC from the inspect bridge output.

# Exec into the first nginx
`sudo docker exec -it nginx bash`

## Run curl to the nginx2
`curl 172.17.0.3`
## We can detect these traffic from both of the containers just like we did before.



