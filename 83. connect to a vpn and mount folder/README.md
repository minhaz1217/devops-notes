# Purpose

I want to connect to a vpn and mount a folder in an NFS so that I can access data from inside that folder

## Connecting to the vpn

#### Install openvpn client using this command

```
apt install openvpn
```

#### Connect to the vpn using this command, here the `config.ovpn` is the vpn config

```
openvpn --config config.ovpn
```

The VPN should be connected now.

## Mounting the folder

#### If the shared folder is a windows folder, then we'll need to install these.

```
sudo apt-get install cifs-utils
```

#### Create a folder where we'll mount our desired folder

```
mkdir ~/test-mount
```

#### Use this command to mount the folder you want

```
sudo mount.cifs //[ip]/[location] ~/test-mount -o user=test_user
```

#### Now we can see that the folder was mounted properly

```
ls ~/test-mount
```

#### To unmount the folder

```
sudo umount ~/test-mount
```
