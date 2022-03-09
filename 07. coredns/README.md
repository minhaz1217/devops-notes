# Installing CoreDNS

Download coredns using 

`wget https://github.com/coredns/coredns/releases/download/v1.9.0/coredns_1.9.0_linux_amd64.tgz`

Unzip the package

`tar xvzf coredns_1.9.0_linux_amd64.tgz`

# Run and test coredns

Now run coredns using this command

`sudo ./coredns -p 1053`

Test that it is working by using this

`dig @127.0.0.1 -p 1053 www.example.com`

coredns will show log of receiving this request.


### Using coredns without any port may cause problem with systemd-resolved.service

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

<br>
<br>

In my case the `systemd-resolved` was using the 53 port before is being auto started everytime I kill it.
### Stop `systemd-resolved`

One way to solve this is the stop the process by using

`sudo systemctl stop systemd-resolved`

### Disabling `systemd-resolved`

Another way is to disable it entierly and then killing it.

`sudo systemctl disable systemd-resolved`

`sudo kill -9 <PID>`

<br>
<br>

Now check again to verify that the 53 port is not being used by any other application.

`sudo netstat -tlpn | grep 53`

### Now run coredns normally by using
`sudo ./coredns`

### Now test that it is receiving request by running
`dig www.example.com`
