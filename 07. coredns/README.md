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