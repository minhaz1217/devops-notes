# Purpose
Here we will add a new user and create ssh files so that that user can login to remove pc via ssh.


# Steps
## All of the commands are working in ubuntu 22.04

### At first create a new user using
`sudo adduser user_name`

Set a secure password for that user and create the user.

### Now from another pc (preferably not the one that user was created) generate ssh key.
`ssh-keygen -t rsa -b 4096 -C "user_name@host_name"`

Enter a custom filename if needed.

### Now log into the machine and switch to the new user using
`su user_name`

### Now enter the content of `*.pub` into the `~/.ssh/authorized_keys` file
`nano ~/.ssh/authorized_keys`

it may throw `no such file or directory` to resolve this `.ssh` folder should be created

```
mkdir ~/.ssh
touch ~/.ssh/authorized_keys
```

### Now you can connect to the host machine using this command
`ssh -i .\<private_key> user_name@host_ip`


### To configure local port forwarding and custom port, we can use this
`ssh -L <port_of_the_local_machine>:localhost:<port_of_the_remote_machine> -p <custom_port> -i .\<private_key> user_name@host_ip`


## Handle the "Unprotected private key  file" error.
### To connect to the remote ps with ssh on windows the security of the private key may need to be changed to achieve that, we can use the following powershell script
```
# Set Key File Variable:
  New-Variable -Name Key -Value "private_key"

# Remove Inheritance:
  Icacls $Key /c /t /Inheritance:d

# Set Ownership to Owner:
  # Key's within $env:UserProfile:
    Icacls $Key /c /t /Grant ${env:UserName}:F

   # Key's outside of $env:UserProfile:
     TakeOwn /F $Key
     Icacls $Key /c /t /Grant:r ${env:UserName}:F

# Remove All Users, except for Owner:
  Icacls $Key /c /t /Remove:g Administrator "Authenticated Users" BUILTIN\Administrators BUILTIN Everyone System Users

# Verify:
  Icacls $Key

# Remove Variable:
  Remove-Variable -Name Key
```

### To use this at first save it in the same directory as the private key with name like `change_permission.ps1`

### Change the `private_key` name if your private key is saved with different name.

### Now open a powershell in the same directory and run `change_permission.ps1`


# Disable  password login

### Edit this file
```
sudo nano /etc/ssh/sshd_config
```

### Search for these keys and make sure the boolean matches, all of these should be set to `no`
```
PasswordAuthentication no
PermitRootLogin no
UsePAM no
ChallengeResponseAuthentication no
```

### Reload the ssh settings using this.
```
sudo systemctl reload ssh
```

### Search for the settings using this.
```
sudo sshd -T | grep -E -i 'ChallengeResponseAuthentication|PasswordAuthentication|UsePAM|PermitRootLogin'
```

### It should output something like this
```
usepam no
permitrootlogin no
passwordauthentication no
```

if after doing everything the settings aren't working, check the files in this directory
```
ls /etc/ssh/sshd_config.d
```

### If it Permissions 0664 for ** are too open. It is required that your private key files are NOT accessible by others.
```
chmod 400 <private_key> -f
```