# Purpose
Nginx proxy manager doesn't allow generating wildcard certificates. Also when I tried to load custom generated certificate it gives error and doesn't accept it. So here I will document how to generate wildcard certificate and configure it with nginx proxy manger.

# Steps
## Install certbot
```
sudo apt-get install certbot -y
```

## Generate the wildcard certificate.
```
sudo certbot certonly -d '*.minhazul.com' -d 'minhazul.com' --manual
```

It will generate a certificate. It will give a challenge. We'll have to go to our domain host and enter the challenge string.

## My domain host is namecheap.
Copy the acme-challenge string and enter it as a TXT Record for your domain.
Type >> txt record
host >> _acme-challenge
value >> the value we just copied



## Use this to `verify` that your TXT record change has been propagated.
```
nslookup -type=TXT _acme-challenge.minhazul.com`
```

## After it is verified, press enter on the console. and it will ask to create a file
## If the certbot gives file data then use this
```
sudo docker exec -it portfolio bash
```

### If it is deployed with basic nginx html server
```
cd /usr/share/nginx/html
```

Replace the `text` given in the challange.
```
echo "text" > "file_name"
```

### For gatsby
```
export ACME_FILE_NAME=<challenge_file_name>
export ACME_VALUE=<challenge_value>

mkdir -p /usr/share/nginx/html/.well-known/acme-challenge/$ACME_FILE_NAME/

echo $ACME_VALUE > "/usr/share/nginx/html/.well-known/acme-challenge/$ACME_FILE_NAME/index.html"
```

### Exit from the container
```
exit
```

### Verify that the content is correct using curl
```
curl --insecure -L http://minhazul.com/.well-known/acme-challenge/zW08nx526fjkPl5LIAkVvM7tr0QPdtJlFKWCeOy-0oU
```

### After verified that the file content exists now press enter and the certificates will be generated.
## Combine the certificates and make the db string to put it in the nginx proxy manager sqlite db.
```
echo "INSERT INTO \"main\".\"certificate\"(\"id\", \"created_on\", \"modified_on\", \"owner_user_id\", \"is_deleted\", \"provider\", \"nice_name\", \"domain_names\", \"expires_on\", \"meta\") VALUES (1, '2022-11-19 18:49:22', '2022-11-19 18:49:22', 1, 0, 'other', 'Wild Card Minhazul', '[\"*.minhazul.com\"]', '$(date -d "3 months" "+%Y-%m-%d %H:%M:%S")', '{ \"certificate\": \"$(sudo cat /etc/letsencrypt/live/minhazul.com/cert.pem )\", \"certificate_key\": \"$(sudo cat /etc/letsencrypt/live/minhazul.com/privkey.pem)\"}');" > nginx_meta
```


## Check that the file has been generated successfully and **copy the content**
```
cat nginx_meta
```

## Install sqlite3
```
sudo apt-get install sqlite3 -y
```
## Now go into the nginx proxy manager sqlite
** In my case the db is located in the `~/database/nginx_proxymanager` location and mounted in the NPM using volume
```
sqlite3 ~/database/nginx_proxymanager/database.sqlite
```

## Paste the db string that you copied in here.
**if you already have an entry here, you can delete the entry using 
or if it throws `Error: UNIQUE constraint failed: certificate.id`

```
select * from "main"."certificate";
```

Notice the id that is causing problem and delete the entry
```
delete from "main"."certificate" where id=1;
```


## Copy the fullchain.pem and privkey.pem file
```
sudo cp /etc/letsencrypt/live/minhazul.com/privkey.pem ~/database/nginx_proxymanager/custom_ssl/npm-1/privkey.pem

sudo cp /etc/letsencrypt/live/minhazul.com/fullchain.pem ~/database/nginx_proxymanager/custom_ssl/npm-1/fullchain.pem
```

## Now restart nginx proxy manager docker container 
```
sudo docker stop nproxy
sudo docker start nproxy
```



# Errors

### Kill a docker container
`ps aux | grep 9a20c2c016bf | awk '{print $1 $2}'`

`ps aux | grep 9a20c2c016bf | head -1 | awk '{print $2}'| xargs sudo kill -9 $1`

### If nginx proxy container log shows **chown: changing ownership of '/data/custom_ssl/npm-1/privkey.pem': Operation not permitted**

#### Check the owner for the .pem files
```
ls -l ~/database/nginx_proxymanager/custom_ssl/npm-1
```
if it shows root or any other user other than the one that is running the container then the user needs to be changed.


```
sudo chown rootless_podman  ~/database/nginx_proxymanager/custom_ssl/npm-1/fullchain.pem
sudo chown rootless_podman  ~/database/nginx_proxymanager/custom_ssl/npm-1/privkey.pem
```



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


#
# Created By - [Minhazul Hayat Khan](https://github.com/minhaz1217)
