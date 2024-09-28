# Purpose
The purpose is to generate SSH key in windows and add that ssh key to github profile for cloning a repo.

# Steps

## Create and add a ssh key to pc

### At first open bash and create a key using this
```
ssh-keygen -t ed25519 -C "your_email@gmail.com"
```

if there is an error generating ed25519 key then use this
```
ssh-keygen -t rsa -b 4096 -C "your_email@gmail.com"
```

### Now open powershell in admin mode and execute these.
```
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
```
To enable auto startup
```
Set-Service ssh-agent -StartupType Automatic
```

```
ssh-add c:/Users/YOU/.ssh/id_ed25519
```

### Add the ssh key to github
Go to 


git config --global user.name "<your name>"
git config --global user.email your_email@gmail.com

test that it is working 
```
ssh git@github.com
```

## Reference
* [https://stackoverflow.com/questions/18683092/how-to-run-ssh-add-on-windows](https://stackoverflow.com/questions/18683092/how-to-run-ssh-add-on-windows)
* [https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui](https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse?tabs=gui)