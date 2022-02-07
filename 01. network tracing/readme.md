# Lookup domain names
## [bgp.he.net](bgp.he.net)

# Get network interfaces or see ip
`ifconfig`

<h3>The eth0 is the default network interface. Our network traffic passes through this interface.</h3>

# Obtaining ip from a domain name
`nslookup www.bing.com`

`ping www.bing.com`

# Obtaining domain name from 
`dig 204.79.197.200`


# Watching traffic via tcpdump
<h3>We can see these traffic with tcpdump</h3>
### Filter by interface
`tcpdump -i eth0`

### Filter by host
`sudo tcpdump host 204.79.197.200`
### Filter by destination
`sudo tcpdump dst 204.79.197.200`
<br/>
<br/>
<h3>We can run <code>tcpdump dst 204.79.197.200</code> and then we send traffic with <code>ping www.bing.com</code>.
Now we can see the traffics.
</h3>
### Chainning multiple conditions

`tcpdump dst 204.79.197.200 or dst 142.250.199.132`

### View http traffic ( get calls )
`tcpdump -vvAls0 | grep 'GET'`

# Check for open port
`telnet 204.79.197.200 80`


