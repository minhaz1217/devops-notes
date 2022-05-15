# Purpose
Here I try to build and publish a dot net application with a single bash script.

# Steps

### If dot net is not installed in the remote machine, install it using this
```
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0
```