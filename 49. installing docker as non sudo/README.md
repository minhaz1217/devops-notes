

# Uninstalling docker

### List the docker packages
```
dpkg -l | grep -i docker
```
### Prune everything (containers and images etc) 
`dockerd-rootless-setuptool.sh uninstall`
`sudo systemctl disable --now docker.service docker.socket`
`/usr/bin/rootlesskit rm -rf /home/dockeruser/.local/share/docker`
`docker system prune -af`

### Uninstall the installed packages
```
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-ce-rootless-extras
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin docker-ce-rootless-extras
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose-plugin docker-ce-rootless-extras
```

### Removing container and other things
```
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf /var/lib/docker /etc/docker
sudo rm -rf /var/run/docker.sock
sudo groupdel docker
sudo rm /etc/apparmor.d/docker
```
If there is problem removing in the /var/lib/docker

### Run this to verify which volumes are mounted.
`cat /proc/mounts | grep docker`

### Use this to unmount the folders 
`umount /var/lib/docker/overlay2/*/merged`
`umount /run/docker/netns/*`




# Installing docker

### add a new user
`sudo adduser dockeruser`
<!-- p -> dockeru -->

### Add the user to sudoer
```
su
visudo
```

### Add this to visudo
`dockeruser ALL=(ALL:ALL) ALL`

### cd in the user directory
`cd ~`
```
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
```

### Create docker group and add the user
`sudo groupadd docker`


# Steps 
### At first install uidmap
`sudo apt-get install -y uidmap`

`sudo apt-get install -y dbus-user-session`


### Disable docker using
```
sudo systemctl disable --now docker.service docker.socket
sudo apt-get install -y docker-ce-rootless-extras
dockerd-rootless-setuptool.sh uninstall
```

```
dockerd-rootless-setuptool.sh install
```

### Edit `~/.bashrc`
`nano ~/.bashrc`

### Add these to 
```
export XDG_RUNTIME_DIR=/home/dockeruser/.docker/run
export PATH=/usr/bin:$PATH
export DOCKER_HOST=unix:///home/dockeruser/.docker/run/docker.sock
```

### Now exit and login again.
`exit`

`systemctl --user start docker`

### If this throw error
`sudo -iu dockeruser`


```
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)
```

`docker context use rootless`


## To access privileged ports (< 1025)
```
sudo setcap cap_net_bind_service=ep $(which rootlesskit)
systemctl --user restart docker
```

```
sudo nano /etc/sysctl.conf
```

### Add this
`net.ipv4.ip_unprivileged_port_start=0`


### Then run
`sudo sysctl --system`