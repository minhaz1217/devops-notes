# Installing CoreDNS

Download coredns using 

`wget https://github.com/coredns/coredns/releases/download/v1.9.0/coredns_1.9.0_linux_amd64.tgz`

Unzip the package

`tar xvzf coredns_1.9.0_linux_amd64.tgz`

Or pick appropriate version for your use from this [Coredns download](https://github.com/coredns/coredns/releases/latest)

# Run and test coredns

Now run coredns using this command

`sudo ./coredns -p 1053`

Test that it is working by using this

`dig @127.0.0.1 -p 1053 www.example.com`

coredns will show log of receiving this request.


### Using coredns without any port may cause problem with systemd-resolved.service

<br><br>

# Using coredns as the default dns resolver.
## Solution for `Listen: listen tcp :53: bind: address already in use`
By default the coredns runs on the 53 port so if any application is running on the 53 port then we can't run coredns in the 53 port

At first run

`sudo netstat -tlpn | grep 53`

Notice the process id (all PID should be same)

Now kill that process by running this command

`sudo kill -9 <PID>`

Check again to verify that the port 53 is not being used by any other application.

`sudo netstat -tlpn | grep 53`

<br><br>

In my case the `systemd-resolved` was using the 53 port before is being auto started everytime I kill it.
### Stop `systemd-resolved`

One way to solve this is the stop the process by using

`sudo systemctl stop systemd-resolved`

### Disabling `systemd-resolved`

Another way is to disable it entierly and then killing it.

`sudo systemctl disable systemd-resolved`

`sudo kill -9 <PID>`

<br><br>

Now check again to verify that the 53 port is not being used by any other application.

`sudo netstat -tlpn | grep 53`

### Now run coredns normally by using
`sudo ./coredns`

### Now test that it is receiving request by running
`dig www.example.com`

<br><br>

# Using plugins with coredns.

Here we will be using plugins using `Corefile`

First add file named `Corefile` on the same directory as the coredns application by using

`touch Corefile`

Now edit the file using 

`nano Corefile`

Add these lines in the Corefile
```
. {
        log
        hosts coredns.hosts
}
```
Here we are using 2 plugins, one is `log`, another is `hosts`. These come bundled with coredns.

We can get the list of all bundled plugins from here [Coredns Plugins](https://coredns.io/plugins/)

The `log` plugin is used to log requests and output in terminal for now.

We are using the `hosts` plugin to map a file that will be used to map dns. <b>This file is auto loaded without restarting coredns</b>.

Create the hosts file using

`touch coredns.hosts`

Edit the hosts file using

`nano coredns.hosts`

Add the following lines
```
127.0.0.1       localhost
192.168.1.10    example.com            example
192.168.5.100   example2.com            example2
```
The hosts file uses the same syntex as the window's hosts file. 

Here we are redirecting all localhost request to 127.0.0.1, and all example.com or example request to 192.168.1.10

Now run coredns using

`sudo ./coredns`

Check that the configuration and plugins are working by running this

`dig example.com`

Notice that the output is 192.168.1.10


## External resources.
[https://github.com/coredns/coredns](https://github.com/coredns/coredns)

[https://stackoverflow.com/questions/53075796/coredns-pods-have-crashloopbackoff-or-error-state/53414041#53414041](https://stackoverflow.com/questions/53075796/coredns-pods-have-crashloopbackoff-or-error-state/53414041#53414041)