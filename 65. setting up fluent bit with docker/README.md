# Purpose
This is a step by step guide about how to setup fluent bit with docker.

The fluent bit official installation guide only had documentation about how to run fluent bit using docker but it didn't mention how to set it up.

So this is my solution to how to setup fluent bit using docker commands only. No docker compose.

# Steps


### Designate a folder where you'll store the fluent bit configs. In my case the directory is `D:/fluent-bit`

### Start a temporary container to copy default configs from
```
docker run -d --rm --name temp cr.fluentbit.io/fluent/fluent-bit
```

### Copy the configs to your designated folder
```
docker cp temp:/fluent-bit/etc/ D:/fluent-bit
```

### Stop the temporary container
```
docker stop temp
```

### Now start fluent bit with the config folder mounted as a volume
```
docker run -dti --name fluent-bit -v D:/fluent-bit:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit
```


### By default fluent bit is configured to output to std out. So see docker log to see what fluent bit is logging.
```
docker logs fluent-bit
```
You'll see something like this
![docker logs output](<images/01. docker logs output.png>)

### Now to make sure that fluent bit is indeed taking configs from our folder. Go to the designated folder and open the fluent-bit.conf folder

### Look for this string
```
tag cpu.local
```

### Change it to this
```
tag CPU_LOCAL
```

### Save the file and restart the container
```
docker restart fluent-bit
```

### Now look at docker logs
```
docker logs fluent-bit
```
Notice that the logs are different.
![Config change worked](<images/02. docker logs to check config.png>)


## References
1. [https://github.com/minhaz1217/devops-notes/tree/master/65.%20setting%20up%20fluent%20bit%20with%20docker](https://github.com/minhaz1217/devops-notes/tree/master/65.%20setting%20up%20fluent%20bit%20with%20docker)
2. [https://docs.fluentbit.io/manual/installation/docker](https://docs.fluentbit.io/manual/installation/docker)

## Published
1. [https://medium.com/@minhaz1217/setting-up-fluent-bit-using-docker-00ee1e19b888](https://medium.com/@minhaz1217/setting-up-fluent-bit-using-docker-00ee1e19b888)
2. [https://dev.to/minhaz1217/setting-up-fluent-bit-using-docker-67n](https://dev.to/minhaz1217/setting-up-fluent-bit-using-docker-67n)