# Opening SSH from local computer

## Purpose

Here I'm showing how to open SSH from your local computer so that you can SSH into your local computer from a github pipeline.


## Steps

#### Install ssh server in your WSL
```
sudo apt-get update
sudo apt-get install openssh-server
```
#### Check the status of the SSH server
```
systemctl status ssh
```

#### Check that you can access your SSH from your own computer.
```
ssh <your user>@127.0.0.1
```

if you don't have a user to login to, you can just create one using this command
```
sudo adduser <username>
```

#### Now go to [this](https://www.noip.com/) website and create an account to get dynamic dns

#### Install dynamic DNS client
```
sudo apt-get install ddclient
```
When prompted to enter data, just keep pressing enter we'll configure it using config file later.

#### Use this command to update the config file
```
nano /etc/ddclient.conf
``` 
#### Add these
```
use=web
ssl=yes
daemon=300
protocol=noip
login={YOUR_EMAIL_HERE}
password={YOUR_PASSWORD_HERE}
<the host name that you got from noip.com>
```

#### Use this command to start the dynamic dns client
```
ddclient
```

#### Use this command to check if ddclient is up
```
ps -ef | grep ddclient
```

#### Now you can access your local computer via ssh using this
```
ssh <your user>@<hostname>
```


## Reference
* [https://www.baeldung.com/linux/ssh-server-dynamic-dns](https://www.baeldung.com/linux/ssh-server-dynamic-dns)