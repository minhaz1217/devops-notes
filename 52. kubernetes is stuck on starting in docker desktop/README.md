# Purpose
When starting up docker kubernetes it is stuck on Starting...

# Solution

1. Delete the folder `C:\ProgramData\DockerDesktop\pki` (Make a backup of it just in case). 
The folder can be located else where: `C:\Users\<user_name>\AppData\Local\Docker\pki`

2. Delete the folder `<user_name>\.kube\` (Again make a backup to be safe)

3. Restart the pc

4. Open docker desktop and wait.