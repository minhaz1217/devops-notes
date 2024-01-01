# Purpose
Here I will setup fluent-bit and seq both with docker and push logs through fluent bit to to seq. 

# Steps

## Setup a docker network for the containers
```
docker network create fluent-bit_seq
```

### Setup a directory to store different shared volumes
```
export sharedFolder=D:/nginx_fluent-bit_seq
```

## Setup nginx

### Copy default nginx configs
```
docker run --name temp -d nginx
docker cp temp:/etc/nginx/ $sharedFolder/nginx/
docker cp temp:/etc/nginx/nginx.conf $sharedFolder/nginx
docker rm -f temp
```


### Build the container that won't link the access log to the stdout
```
docker build -t nginx_without_log_link .
```

### Start nginx with the config we just copied and with a log folder mounted and our new image
```
docker run --name nginx -v $sharedFolder/nginx:/etc/nginx -v $sharedFolder/logs:/var/log/nginx -p 80:80 -p 443:443 --network fluent-bit_seq -d nginx_without_log_link
```

## Setup Fluent Bit

### Start a temporary container to copy default configs from
```
docker run -d --rm --name temp cr.fluentbit.io/fluent/fluent-bit
```

### Copy the configs to your designated folder
```
docker cp temp:/fluent-bit/etc/ $sharedFolder/fluent-bit
```

### Stop the temporary container
```
docker stop temp
```

### Now start fluent bit with the config folder mounted as a volume
```
docker run -dti --name fluent-bit --network fluent-bit_seq -v $sharedFolder/logs:/var/custom/logs -v $sharedFolder/fluent-bit:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit
```


### By default fluent bit is configured to output to std out. So see docker log to see what fluent bit is logging.
```
docker logs fluent-bit
```

## Setup Seq

### At first setup a hashed password to be used
```
PH=$(echo 'seqPass%%' | docker run --rm -i datalust/seq config hash)
```

### Make sure that the password variable is ok
```
echo $PH
```

### Run the container
```
docker run --name seq2 -d --network fluent-bit_seq -p8080:80 --restart unless-stopped -e ACCEPT_EULA=Y -e SEQ_FIRSTRUN_ADMINPASSWORDHASH="$PH" datalust/seq
```

### Now browse to `localhost:8080` and login into Seq using username=admin password=seqPass%%


## Configuring Fluent Bit to send logs to Seq

### Go to the fluent bit configuration directory and search for this section
```
[OUTPUT]
    name  stdout
    match *
```

### Replace this section with this and save
```
[OUTPUT]
    Name             http
    Match            *
    Host             seq
    Port             5341
    URI              /api/events/raw?clef
    Format           json_lines
    Json_date_key    @t
    Json_date_format iso8601
    Log_response_payload False
```

### Now restart the fluent bit container for the changes to take effect.
```
docker restart fluent-bit
```

Now browse to `localhost:8080` and login into Seq using username=admin password=seqPass%% and see that the logs are being written into Seq


## Now we will read the nginx logs and output it to seq

### Go to the fluent-bit.conf file
```
@INCLUDE nginx.conf
```

### This is the content of nginx.conf file
```

[SERVICE]
    flush        1
    daemon       Off
    log_level    info

[INPUT]
    Name  tail
    tag  nginx_access_log.tag
    Parser nginx
    Path  /var/custom/logs/*.log

[FILTER]
    Name    modify
    Match   *
    Rename  log @m

[OUTPUT]
    Name             http
    Match            *
    Host             seq
    Port             5341
    URI              /api/events/raw?clef
    Format           json_lines
    Json_date_key    @t
    Json_date_format iso8601
    Log_response_payload False

```