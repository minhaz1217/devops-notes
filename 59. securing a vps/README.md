# Securing a vps ubuntu22

## Changing password

### Change the current user password
```
passwd
```

### Changing root password
```
sudo passwd
```


## Upgrading the system
```
sudo apt update
sudo apt upgrade
```

## Changing the default SSH listening port

### Open the file
```
sudo nano /etc/ssh/sshd_config
```

### Search for the string `Port 22` replace this with what port you want like maybe `Port 223`

if this line is commented out, remove the `#` from the start of the line

### Restart the service
```
sudo systemctl restart sshd
```
This should already make the port change to take effect, if not, restart the vps using `sudo reboot`

### Now check the status to make sure that the port change was successful
```
sudo systemctl status sshd
```

## Creating new user
```
sudo adduser CustomUserName
```

## Disable server access via root user

### Edit the file
```
sudo nano /etc/ssh/sshd_config
```

### Find this section
```
# Authentication: 
LoginGraceTime 120
PermitRootLogin yes 
StrictModes yes
```

### Change the `PermitRootLogin` to `no`
```
PermitRootLogin no
```

### Restart the service
```
PermitRootLogin no
```

Now try to login via root and is should be disabled