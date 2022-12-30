# Purpose
Here I try to build and publish a dot net application with a single bash script.

# Requirements
* WSL in local pc
* dotnet in the remote pc

## To install WSL follow these instructions [here](https://docs.microsoft.com/en-us/windows/wsl/install)


## To install dotnet sdk in remote pc
```
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```
```
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0
```


## Edit the configurations in the .bat file according to your needs. 

### Just run the file using
`publish_application.bat`


#
# Created By - [Minhazul Hayat Khan](https://github.com/minhaz1217)
