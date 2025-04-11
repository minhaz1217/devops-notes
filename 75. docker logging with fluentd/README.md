

docker run --rm --log-driver=fluentd --log-opt tag="docker.{{.ID}}" ubuntu echo 'Hello Fluentd!'

docker run --rm -it --network logs-grafana-loki --log-driver=loki --log-opt loki-url="http://host.docker.internal:3100/loki/api/v1/push" --log-opt loki-retries=5 --log-opt loki-batch-size=1 hello-world:latest



### Create a network
```
docker network create logs-fluentd
```

### Set project root location

Set the project root to desired location, in this case, this folder
```
set PROJECT_ROOT $PWD
```

### Start fluentd
```
docker run -dit --name fluentd --network logs-fluentd -p 24224:24224 -v $PROJECT_ROOT/config:/fluentd/etc fluent/fluentd:edge-debian -c /fluentd/etc/in_docker.conf
```

### Test it using
```
curl -X POST -d 'json={"json":"message"}' http://127.0.0.1:9880/sample.test
```

```
docker run --rm --log-driver=fluentd --log-opt tag="docker.{{.ID}}" ubuntu echo 'Hello Fluentd!'
```
```
docker run --rm -it --network minhazul-net --log-driver gelf --log-opt gelf-address=udp://seq:12201 hello-world:latest
docker run --rm -it --network minhazul-net --log-driver gelf --log-opt gelf-address=udp://172.17.0.2:12201 --log-opt tag="{ 'source': 'docker_logs' }" hello-world:latest
```