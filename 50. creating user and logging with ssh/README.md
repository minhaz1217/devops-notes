# Purpose
Here we will add a new user and create ssh files so that that user can login to remove pc via ssh.

# Steps
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

### Now you can connect to the host machine using this command
`ssh -i .\<private_key> user_name@host_ip`


### To configure local port forwarding and custom port, we can use this
`ssh -L <port_of_the_local_machine>:localhost:<port_of_the_remote_machine> -p <custom_port> -i .\<private_key> user_name@host_ip`
