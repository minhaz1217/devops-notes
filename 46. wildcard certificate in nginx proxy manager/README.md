# Purpose
Nginx proxy manager doesn't allow generating wildcard certificates. Also when I tried to load custom generated certificate it gives error and doesn't accept it. So here I will document how to generate wildcard certificate and configure it with nginx proxy manger.

# Steps
## Generate the wildcard certificate.
`sudo certbot certonly -d '*.minhazul.com' --manual`

It will generate a certificate. It will give a challenge. We'll have to go to our domain host and enter the challenge string.

## My domain host is namecheap.
Copy the acme-challenge string and enter it as a TXT Record for your domain.


## Use this to test that your TXT record change has been propageted.
`nslookup -type=TXT _acme-challenge.minhazul.com`


## Combine the certificates and make the db string to put it in the nginx proxy manager sqlite db.
`echo "INSERT INTO \"main\".\"certificate\"(\"id\", \"created_on\", \"modified_on\", \"owner_user_id\", \"is_deleted\", \"provider\", \"nice_name\", \"domain_names\", \"expires_on\", \"meta\") VALUES (1, '2022-02-06 18:49:22', '2022-02-06 18:49:22', 1, 0, 'other', 'Wild Card Minhazul', '[\"*.minhazul.com\"]', '2022-05-03 15:58:46', '{ \"certificate\": \"$(sudo cat /etc/letsencrypt/live/minhazul.com/cert.pem )\", \"certificate_key\": \"$(sudo cat /etc/letsencrypt/live/minhazul.com/privkey.pem)\"}');" > nginx_meta`


## Check that the file has been generated successfully and copy the content
`cat nginx_meta`

## Now go into the nginx proxy manager sqlite.
** In my case the db is located in the `~/database/nginx_proxymanager` location
`sudo sqlite3 database/nginx_proxymanager/database.sqlite`

## Paste the db string that you copied in here.
**if you already have an entry here, you can delete the entry using

`select * from "main"."certificate;"`
`delete from "main"."certificate" where id=1`


## Copy the fullchain.pem and privkey.pem file
```
sudo cp /etc/letsencrypt/live/minhazul.com/privkey.pem ~/database/nginx_proxymanager/custom_ssl/npm-1/privkey.pem

sudo cp /etc/letsencrypt/live/minhazul.com/fullchain.pem ~/database/nginx_proxymanager/custom_ssl/npm-1/fullchain.pem
```

## Now restart nginx proxy manager docker container 
`sudo docker stop nproxy`

`sudo docker start nproxy`

## Kill a docker container
`ps aux | grep 4efbcd5b1575 | awk '{print $1 $2}'`

`ps aux | grep 4efbcd5b1575 | head -1 | awk '{print $2}'| xargs sudo kill -9 $1`



<!-- sudo ls -l /home/minhazvps/database/nginx_proxymanager/custom_ssl/npm-1
sudo unlink /home/minhazvps/database/nginx_proxymanager/custom_ssl/npm-1/fullchain.pem
sudo unlink /home/minhazvps/database/nginx_proxymanager/custom_ssl/npm-1/privkey.pem



sudo cp /etc/letsencrypt/live/minhazul.com/privkey.pem ~/database/nginx_proxymanager/custom_ssl/npm-1/privkey.pem
sudo cp /etc/letsencrypt/live/minhazul.com/fullchain.pem ~/database/nginx_proxymanager/custom_ssl/npm-1/fullchain.pem

sudo ln -sf /etc/letsencrypt/live/minhazul.com/privkey.pem ~/database/nginx_proxymanager/custom_ssl/npm-1/privkey.pem
sudo ln -sf /etc/letsencrypt/live/minhazul.com/fullchain.pem ~/database/nginx_proxymanager/custom_ssl/npm-1/fullchain.pem


sudo ln -sf /etc/letsencrypt/live/minhazul.com/cert.pem ~/database/nginx_proxymanager/letsencrypt/live/minhazul.com/cert.pem
sudo ln -sf /etc/letsencrypt/live/minhazul.com/chain.pem ~/database/nginx_proxymanager/letsencrypt/live/minhazul.com/chain.pem
sudo ln -sf /etc/letsencrypt/live/minhazul.com/fullchain.pem ~/database/nginx_proxymanager/letsencrypt/live/minhazul.com/fullchain.pem
sudo ln -sf /etc/letsencrypt/live/minhazul.com/privkey.pem ~/database/nginx_proxymanager/letsencrypt/live/minhazul.com/privkey.pem

sudo ln -sf /etc/letsencrypt/live/minhazul.com/cert.pem ~/database/nginx_proxymanager/letsencrypt/archive/minhazul.com/cert1.pem
sudo ln -sf /etc/letsencrypt/live/minhazul.com/chain.pem ~/database/nginx_proxymanager/letsencrypt/archive/minhazul.com/chain1.pem
sudo ln -sf /etc/letsencrypt/live/minhazul.com/fullchain.pem ~/database/nginx_proxymanager/letsencrypt/archive/minhazul.com/fullchain1.pem
sudo ln -sf /etc/letsencrypt/live/minhazul.com/privkey.pem ~/database/nginx_proxymanager/letsencrypt/archive/minhazul.com/privkey1.pem -->