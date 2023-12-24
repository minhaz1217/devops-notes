# Purpose
Here I will be installing rootless podman, which will allow podman to run from a rootless user.


## Steps

## Create an user that will run rootless podman
`sudo adduser rootless_podman`



## Execute these commands as a sudoer
```
sudo apt-get update
sudo apt-get -y install podman
```
### Installing slirp4netns
```
sudo apt-get install slirp4netns
```
### Check the files for the created user's entries
```
grep rootless_podman /etc/subuid /etc/subgid
```



### If everything is ok and subuid and subgid is showing then run these
```
sudo chown -R rootless_podman:rootless_podman /home/rootless_podman/
sudo chown -R rootless_podman:rootless_podman /home/rootless_podman/.local/share/containers/storage/overlay/l
sudo chown -R rootless_podman:rootless_podman /run/user/1001/

```



### To verify if the setup was correct, use this
```
sudo -u rootless_podman bash -c "cd ~; podman ps"
```

### It should output something like this
```
CONTAINER ID  IMAGE       COMMAND     CREATED     STATUS      PORTS       NAMES
```


### Switch to the user
```
su - rootless_podman
```

### Use podman
```
podman ps
```


### Adding registry entries
```
sudo nano /etc/containers/registries.conf
```
### Add these
```
[registries.search]
registries = ['docker.io', 'registry.fedoraproject.org', 'quay.io', 'registry.access.redhat.com', 'registry.centos.org']

```

### Extra stuff
### you have have to enable linger for the user that will run podman
```
id -u rootless_podman
```

### Take note of the id and use the id in the bellow command
```
loginctl enable-linger <id>
```

## Execute these as the user that will run podman

# Reference
* https://podman.io/docs/installation#linux-distributions
* https://github.com/containers/podman/blob/main/docs/tutorials/rootless_tutorial.md
* https://devpress.csdn.net/linux/62ea013920df032da732abb7.html