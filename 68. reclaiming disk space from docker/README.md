# Purpose
Currently my `.vhdx` file is at 97GB. The file is located in the `%USERPROFILE%\AppData\Local\Docker\wsl\data\ext4.vhdx` folder
I have cleared all the unused images and containers. Still the size remains this high. So here I'll clear it.

After the cleanup the file is only ~20GB. So I've reclaimed ~75GB of my ssd's space.

# Steps
High disk usage by the docker virtual harddisk image file.

![alt text](<images/all are being used by the virtual drive.png>)

I use a dedicated drive to be used only for docker virtual disk.

![alt text](images/high-disk-space.png)


From inside the docker desktop these are the images.
![alt text](<images/all docker images.png>)

### At first see the list
```
wsl --list -v
```
![wsl list](<./images/01. wsl_list.png>)


### Run this command and make sure that all of them are shut down
```
wsl --shutdown

or

wsl  --shutdown <name>
```

![after shutdown](<./images/02. after shutdown.png>)

### Run this to create a backup for all the current data
```
wsl --export docker-desktop-data <location>

example - 

wsl --export docker-desktop "D:\docker-desktop.tar"
```

<!-- wsl --export docker-desktop "D:\docker-desktop-optimized.tar" -->

### Run this to unregister all the items ( this will also remove the .vhdx)
```
wsl --unregister docker-desktop-data
wsl --unregister docker-desktop
```
![alt text](images/unregistered.png)

### The .vhdx file should get removed automatically


![alt text](<images/disk reclaimed.png>)

### Run this to create new .vhdx file from the backup
```
wsl --import docker-desktop-data "C:\Users\HA HA\AppData\Local\Docker\wsl\data" "D:\docker-desktop-data.tar" --version 2
```
this will take the .tar file from D drive and create a .vhdx file in C drive.

wsl --import docker-desktop "G:\DockerDesktopWSL\disk" "D:\docker-desktop-base.tar" --version 2

<!-- wsl --import docker-desktop-data "G:\DockerDesktopWSL\disk" "D:\docker-desktop-optimized.tar" --version 2 -->
### Use existing .vhdx
```
try this first >> wsl --import-in-place docker-desktop-data G:\DockerDesktopWSL\disk\docker_data.vhdx
wsl --import-in-place docker-desktop G:\DockerDesktopWSL\disk\docker_data.vhdx
```
<!-- wsl --import-in-place docker-desktop-data C:\Users\HA HA\AppData\Local\Docker\wsl\disk\docker_data.vhdx -->


# Reference
1. https://stackoverflow.com/questions/62441307/how-can-i-change-the-location-of-docker-images-when-using-docker-desktop-on-wsl2