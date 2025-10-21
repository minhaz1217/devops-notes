# Purpose
The purpose of this is to list my journey on how I've analyzed a memory issue  for a dotnet project. The project is running on a linux vm within docker.

## Taking the dump

### Installing dotnet-sdk inside the container

The first problem we faced was to install the dump tools inside the container that runs the docker image. The container was dotnet-runtime container for docker.

<!-- How to install the dump tools, manual installation and taking the dump, inside the dotnet-runtime docker base -->
```

```

#### Get inside the container by running
```
docker exec -it <container_id> bash
```

#### Update & upgrade packages
```
apt-get update
apt-get upgrade -y
```

![alt text](<images/01. run apt update.png>)

#### Run these commands
These steps follow guideline from [here](https://learn.microsoft.com/en-us/dotnet/core/install/linux-debian) 
```
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

dpkg -i packages-microsoft-prod.deb

rm packages-microsoft-prod.deb

apt-get update

apt-get install -y dotnet-sdk-6.0
```

#### Take the dump
To take the dump we need to install dotnet-dump tool. Run this command
```
dotnet tool install --global dotnet-dump
```
Run this command to get the process id
```
dotnet-counters ps

dotnet-dump ps
```

![alt text](<./images/02. get process id.png>)

*If runnings this command gives `bash: dotnet-dump: command not found` then run this command.*

```
export PATH="$PATH:$HOME/.dotnet/tools"

```

![alt text](<images/03. command not found.png>)


Run this command to get the dump
```
dotnet-dump collect -p  <process_id>
```
![alt text](<images/04. collect dump.png>)



#### To collect gcdump install the tool using this
```
dotnet tool install --global dotnet-gcdump
```
#### Take the dump
```
dotnet-gcdump ps
dotnet-gcdump collect -p <process-id>
```

I have these 2 dumps
![alt text](<images/05. dump list.png>)


Now to copy these files into local computer.
```
```


```
dotnet tool install --global dotnet-dump

dotnet-dump collect -p <process-id>
 
dotnet-counters ps
 
dotnet tool install --global dotnet-gcdump
dotnet-gcdump ps
dotnet-gcdump collect -p <process-id>
 
```

```
docker cp <container_id>:<path inside the container> <path inside the computer>

docker cp ffef:/downloads/ D:/dumps/
```

### Analyze the dump
```
ERROR: No CLR runtime found.
```

if this issue is found `ERROR: No CLR runtime found.`

one reason for this is that the dump taken on different OS than the OS we are trying to analyze from. In my case this is because I took the dump from inside linux(container runs on debian) and was trying to analyze it from windows

```
docker cp D:/c_dump/core_20251009_072605 ffef:/downloads/core_20251009_072605
```
```
dotnet-dump analyze core_20251009_072605
```


all commands
```
dotnet tool install --global dotnet-debugger-extensions
dotnet-debugger-extensions install --architecture X64

dumpheap -stat

dotnet tool install --global dotnet-symbol

dotnet-symbol --host-only --debugging <dump file path>

dotnet-dump collect -p 1234 --type Full -o myapp_memory_dump.dmp

dotnet-dump collect -p <ProcessId> --type Full -o <output_filename>.dmp
```


* https://learn.microsoft.com/en-us/dotnet/core/diagnostics/debug-memory-leak?WT.mc_id=DT-MVP-5004452
* https://learn.microsoft.com/en-us/dotnet/core/diagnostics/debug-linux-dumps