# Opening SSH from local computer

## Purpose

Here I'm showing how to open SSH from your local computer and ssh into it from another remote computer.


## Steps

## Installing and enabling Open SSH

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

## Installing zrok

#### Run this command to install zrok
```
curl -sSf https://get.openziti.io/install.bash | sudo bash -s zrok
```

#### After signing up to zrok, Go to [here](https://api-v1.zrok.io/) token
```
zrok enable <token>
```

#### Now share your port 22 using this command
```
zrok share private --headless --backend-mode tcpTunnel 127.0.0.1:22
```

#### To run it in headless mode, use this
```
zrok share private --headless --backend-mode tcpTunnel 127.0.0.1:22
```

#### On the server that you to ssh from use this
```
zrok access private <connection_token>
```

#### To make it run on background you can use this command
```
zrok access private --headless <connection_token> &
```

#### To make sure that you can communicate to the machine run this command
```
nc 127.0.0.1 9191
```

#### Now you can access your local computer via ssh using this
```
ssh -i <private_key> 127.0.0.1 -p 9191 -l <user>

example:

ssh -i .\pkey 127.0.0.1 -p 9191 -l user
```
