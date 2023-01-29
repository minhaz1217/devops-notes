

# Uninstalling docker

### List the docker packages
```
dpkg -l | grep -i docker
```
### Prune everything (containers and images etc) 
`docker system prune -af`

### Uninstall the installed packages
```
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli docker-compose-plugin docker-ce-rootless-extras
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose-plugin docker-ce-rootless-extras
```

### Removing container and other things
```
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock
```
If there is problem removing in the /var/lib/docker

### Run this to verify which volumes are mounted.
`cat /proc/mounts | grep docker`

### Use this to unmount the folders 
`umount /var/lib/docker/overlay2/*/merged`
