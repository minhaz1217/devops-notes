# Purpose
Here we will be trying to simulate container communication in different nodes using vxlan with openvswitch.


# Steps
### At first get your 2 instance/nodes setup and make sure that the nodes can communicate with each other using 
`ping <node_ip>`

## Installing necessary softwares

### Install docker
```
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update

sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io
```

### Docker post installation steps
```
sudo groupadd docker
sudo usermod -aG docker ubuntu
logout
```
### Install openvswitch
`sudo apt -y install openvswitch-switch`
<hr>

## Do this on the target machine
### Create a docker network
```
docker network create --driver=bridge --subnet=172.21.0.0/16 --ip-range=172.21.0.0/16 --gateway=172.21.0.254 receiver-network
```
### Make sure that the network was create using
`sudo docker network list`

### Now create a container that will receive the request
`docker run -di --name receiver --network=receiver-network alpine`

### Get the ip of the created container using
`sudo docker inspect receiver`

for my case the ip is 172.21.0.1

### Make sure that your machine can ping the target container using
`ping 172.21.0.1`


<hr>

## Do this in the sender machine.
### Create an alpine docker container that will act as the target server
`docker run -di --name al1 alpine`

### Add a bridge to openvswitch
`sudo ovs-vsctl add-br br0`

### Add a VXLAN port to the new openvswitch bridge and configure a remote VTEP address and VNI to be assigned to that port.
`sudo ovs-vsctl add-port br0 vxlan1 -- set interface vxlan1 type=vxlan options:remote_ip=3.110.46.166 options:key=1`


### Use the ovs docker tool to add a port container the docker container and ovs bridge
`sudo ovs-docker add-port br0 eth0 al1 --ipaddress=172.21.0.0/16`

### Ping the container using
`docker exec al1 ping 172.21.0.1`

### Clean up
```
sudo ovs-docker del-port br0 eth0 al1
sudo ovs-vsctl del-br br0
docker kill al1
docker rm al1
```
<hr>

## Communicating between 2 containers using vxlan.

### Create 2 containers
```
sudo docker run -dit --name sender ubuntu bash
sudo docker run -dit --name receiver ubuntu bash
```
### We will try to ping container2 from container1
### Install ping tool in container1
```
sudo docker exec -it sender apt update

sudo docker exec -it sender apt install iputils-ping -y
```

### Get ipaddress of container2
`sudo docker inspect receiver`

in my case the ip address of receiver is 172.24.0.2

### Ping receiver
`sudo docker exec -it sender ping 172.24.0.2`

The ping request should fail.

### Create a ovs bridge
`sudo ovs-vsctl add-br ovs-br1`

### use this to see the bridges.
`sudo ovs-vsctl show`


### Configure internal ip address to the bridge.
`sudo ifconfig ovs-br1 173.16.1.1 netmask 255.255.255.0 up`

### Configure the containers to have ip on that bridge
```
sudo ovs-docker add-port ovs-br1 eth0 sender --ipaddress=173.16.1.2/24

sudo ovs-docker add-port ovs-br1 eth0 receiver --ipaddress=173.16.1.3/24
```
The output should be `RTNETLINK answers: File exists`

### Now from container1 ping the container2
`sudo docker exec -it sender ping 173.16.1.3`


### Clean up
```
sudo ovs-docker del-port ovs-br1 eth0 sender
sudo ovs-docker del-port ovs-br1 eth0 receiver
docker kill sender receiver
docker rm sender receiver
sudo ovs-vsctl del-br ovs-br1
```

























# References
* [https://www.nullzero.co.uk/docker-openvswitch-aruba-vxlan-network-build/](https://www.nullzero.co.uk/docker-openvswitch-aruba-vxlan-network-build/)
* [https://www.tutorialspoint.com/how-to-use-an-ovs-bridge-for-networking-on-docker](https://www.tutorialspoint.com/how-to-use-an-ovs-bridge-for-networking-on-docker)