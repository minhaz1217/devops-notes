

### Create a network
```
docker network create logs-grafana-loki
```

### Set project root location

Set the project root to desired location, in this case, this folder
```
set PROJECT_ROOT $PWD
```

### Install loki
```
docker run -dit --name loki -p3100:3100 --network logs-grafana-loki -v $PROJECT_ROOT/logs-grafana-loki/loki/config:/etc/loki -v $PROJECT_ROOT/logs-grafana-loki/loki/data:/tmp/loki grafana/loki:2.9.2 --config.file=/etc/loki/loki-config.yaml
```
To check readyness
`http://localhost:3100/ready`

To check for the metrics
`http://localhost:3100/metrics`

### Install grafana
```
docker run -dit -p 3000:3000 --network logs-grafana-loki --name grafana -v $PROJECT_ROOT/grafana:/var/lib/grafana -e "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource"  grafana/grafana:latest
```

### install Enable loki plugin for docker
```
docker plugin install  grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
docker plugin enable loki
```

### Testing
```
docker run --rm -it --network logs-grafana-loki --log-driver=loki --log-opt loki-url="http://host.docker.internal:3100/loki/api/v1/push" --log-opt loki-retries=5 --log-opt loki-batch-size=1 hello-world:latest
```
