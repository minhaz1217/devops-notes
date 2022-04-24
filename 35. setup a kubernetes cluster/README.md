
## Setup vagrant (optional)

### Install vagrant using
[https://www.vagrantup.com/docs/installation](https://www.vagrantup.com/docs/installation)

### At first set the hypervisorlaunchtype to off
`bcdedit /set hypervisorlaunchtype off`

Then restart, **You might need to restart 2 times.
# Manual setup
## Setting up vagrant VMs
### Bring up all the necessary VMs
```
cd manual-setup/master-node-01
vagrant up
cd ../worker-node-01
vagrant up
cd ../worker-node-02
vagrant up
```

### SSH into the vagrant box using 
`vagrant ssh`

## Do this on both the worker and master nodes

### Disable swap
```
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```

### Enable iptables bridged traffic
```
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system
```
### Install docker

```
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
```
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```
### Enable docker cgroup
```
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
```
```
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
```
## Install kubeadm, kubelet and kubectl

```
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
```
`echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list`

```
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

## Do these in master node
<!-- IPADDR="10.10.10.100" -->
### See the ip address of eth0 using
`ifconfig`
set the ipv4 address as the `IPADDR`
### Setup environment variables for node setup
```
IPADDR="<master_node's_eth0's_ip>"
NODENAME=$(hostname -s)
```
NODENAME=master-node-01
IPADDR=10.10.12.94



### (optional) In ec2 we may need to add the NODENAME in the hosts file
`sudo nano /etc/hosts`

`sudo kubeadm init --apiserver-advertise-address=$IPADDR  --apiserver-cert-extra-sans=$IPADDR  --pod-network-cidr=192.168.0.0/16 --node-name $NODENAME --ignore-preflight-errors Swap --v=5`
<!-- `curl -fsL https://raw.githubusercontent.com/minhaz1217/linux-configurations/master/bash/03.%20installing%20docker/install_docker.sh | bash -` -->

### To use kubectl do this as normal user
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
or if this error occurs when trying any kubectl command `The connection to the server localhost:8080 was refused - did you specify the right host or port?`


### Create a token for worker nodes to connect
`sudo kubeadm token create --print-join-command`

## If anything bad happens during kubeadm init or join we can reset by using
```
rm /etc/kubernetes/kubelet.conf
rm -rf /etc/kubernetes/pki
systemctl stop kubelet
```
`sudo kubeadm reset`

## Do these to setup the worker node
`NODENAME=$(hostname -s)`

### Copy the contents of `/etc/kubernetes/admin.conf` from the master machine to the worker machine
`sudo cat /etc/kubernetes/admin.conf`

### (optional) check the hash of the admin.conf in both master and worker node to make sure that they are identical
`sudo sha256sum /etc/kubernetes/admin.conf`

### In the master node generate the string for joining
`kubeadm token create --print-join-command`
### Paste the join command in the worker node

### In the master node label the node as worker node
`kubectl label node worker-node-01 node-role.kubernetes.io/worker=worker`


### Now we should be able to see our worker node from the master node using
`kubectl get nodes`

The node status should be not ready.
### We can inspect that the nodes are having problem using
`kubectl describe nodes`

We'll notice that the error is **container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:docker: network plugin is not ready: cni config uninitialized**

### We can see the pods of the default kubernetes namespace using
`kubectl get pods -n kube-system`

We'll see that 2 coredns pods are showing status pending.

### To solve these we'll install a network plugin named Calico

## Setting up network plugin
### Download the calico plugin
`curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O`

### Apply it
`kubectl apply -f calico.yaml`

If default configuration is changed we may need to follow calico plugin's installation guide

### Now if we get nodes we'll see status **Ready**
`kubectl get nodes`

### We can get kube system pods using
`kubectl get pods -n kube-system`


## Reference
[https://devopscube.com/setup-kubernetes-cluster-kubeadm/](https://devopscube.com/setup-kubernetes-cluster-kubeadm/)

[https://projectcalico.docs.tigera.io/getting-started/kubernetes/self-managed-onprem/onpremises](https://projectcalico.docs.tigera.io/getting-started/kubernetes/self-managed-onprem/onpremises)