# Purpose
Currently my `.vhdx` file is at 97GB. The file is located in the `%USERPROFILE%\AppData\Local\Docker\wsl\data\ext4.vhdx` folder
I have cleared all the unused images and containers. Still the size remains this high. So here I'll clear it.

After the cleanup the file is only ~20GB. So I've reclaimed ~75GB of my ssd's space.

# Steps


### At first see the list
```
wsl --list -v
```


### Run this command and make sure that all of them are shut down
```
wsl  --shutdown <name>

wsl --shutdown docker-desktop-data
wsl --shutdown docker-desktop
```

### Run this to create a backup for all the current data
```
wsl --export docker-desktop-data "D:\docker-desktop-data.tar"
wsl --export docker-desktop "D:\docker-desktop.tar"
```
wsl --export docker-desktop "D:\docker-desktop-optimized.tar"

### Run this to unregister all the wsls ( this will also remove the .vhdx)
```
wsl --unregister docker-desktop-data
wsl --unregister docker-desktop
```

### The .vhdx file should get removed automatically

### Run this to create new .vhdx file from the backup
```
wsl --import docker-desktop-data "C:\Users\HA HA\AppData\Local\Docker\wsl\data" "D:\docker-desktop-data.tar" --version 2
```
this will take the .tar file from D drive and create a .vhdx file in C drive.

### Use existing .vhdx
```
wsl --import-in-place docker-desktop G:\DockerDesktopWSL\disk\docker_data.vhdx
```



# Reference
1. https://stackoverflow.com/questions/62441307/how-can-i-change-the-location-of-docker-images-when-using-docker-desktop-on-wsl2