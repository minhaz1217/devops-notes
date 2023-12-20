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

## Installing Fail2Ban

```
sudo apt install fail2ban
```

### Copy the config
```
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
```

### Edit the file
```
sudo nano /etc/fail2ban/jail.local
```

### Find this section
```
[sshd]
```

### Change the file to reflect like this.
```
[sshd]
enabled = true
port = ssh
filter = sshd
maxretry = 3
findtime = 5m
bantime  = 30m
```

### Restart fail2ban
```
sudo service fail2ban restart
```

### To verify that fail2ban is running use this
```
sudo fail2ban-client status
```
### It should show something like this
```
Status
|- Number of jail:      1
`- Jail list:   sshd

```
if it shows this error

`ERROR   Failed to access socket path: /var/run/fail2ban/fail2ban.sock. Is fail2ban running?`

try running this
```
sudo fail2ban-client start
```

### If everything is ok then enable fail2ban to start on boot
```
sudo systemctl enable fail2ban
```