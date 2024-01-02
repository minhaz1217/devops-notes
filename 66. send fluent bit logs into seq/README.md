# Purpose
Here I will setup fluent-bit and seq both with docker and push logs through fluent bit to to seq. 
I will also show how to setup fluent bit and seq with docker.

# Steps

## Setup a docker network for the containers
```
docker network create fluent-bit_seq
```

## Setting up Seq

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
![Logging into seq](<images/01. logging into seq.png>)


![After logging into seq](<images/02. after logging into seq.png>)

## Setting up Fluent Bit


### Designate a folder where you'll store the fluent bit configs. In my case the directory is `D:/fluent-bit`

### Set the directory where fluent bit's config will come from
```
export sharedFolder=/tmp/fluent-bit_seq
```

### Start a temporary container to copy default configs from
```
docker run -d --rm --name temp cr.fluentbit.io/fluent/fluent-bit
```

### Copy the configs to your designated folder
```
docker cp temp:/fluent-bit/etc/ $sharedFolder
```

### Stop the temporary container
```
docker stop temp
```

### Now start fluent bit with the config folder mounted as a volume
```
docker run -dti --name fluent-bit --network fluent-bit_seq -v $sharedFolder:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit
```
![See what is in the shared folder directory](<images/03. see what is in the shared folder directory.png>)

### By default fluent bit is configured to output to std out. So see docker log to see what fluent bit is logging.
```
docker logs fluent-bit
```
![Fluent bit logs](<images/04. fluent bit logs.png>)

## Configuring Fluent Bit to send logs to Seq

### Go to the fluent bit configuration directory and search for this section

For our case it will be $sharedFolder/fluent-bit.conf

```
nano $sharedFolder/fluent-bit.conf
```

### Then find this bit
```
# fluent-bit.conf
[OUTPUT]
    name  stdout
    match *
```

### Replace this section with this and save
```
# fluent-bit.conf
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
![after pasting the config](<images/05. after pasting the config.png>)


### Now restart the fluent bit container for the changes to take effect.
```
docker restart fluent-bit
```

Now browse to `localhost:8080` and login into Seq using username=admin password=seqPass%% and see that the logs are being written into Seq

![Fluent bit is sending message to seq](<images/06. fluent bit is sending message to seq.png>)