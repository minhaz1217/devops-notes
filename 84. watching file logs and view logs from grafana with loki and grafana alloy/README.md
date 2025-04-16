# Purpose

The purpose of this is that we have a file log.txt, our application will write log to this file, we want to send the logs written in this file into grafana.

To achieve this we'll use grafana alloy to watch over this file, then we'll send the logs to loki and then query loki from inside grafana.

## Initial setup

Create the network used in this documentations
```
docker network create log-alloy
```

Set the project root to desired location, in this case, this folder
```
set PROJECT_ROOT $PWD
```


## Setup loki

```
docker run -dit --name loki -p3100:3100 -v $PROJECT_ROOT/loki/config/:/etc/loki/ -v $PROJECT_ROOT/loki/data:/tmp/loki --network log-alloy grafana/loki:3.4.1  --config.file=/etc/loki/loki-config.yaml
```

## Setup grafana

```
docker run -dit -p 3000:3000 --network log-alloy --name grafana -e "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource"  grafana/grafana:latest
```

## Setup grafana-alloy

```
docker run -dit --name alloy --network log-alloy -v C:/Log:/log-root/ -v ${PROJECT_ROOT}/alloy-config/config.alloy:/etc/alloy/config.alloy -p 12345:12345 grafana/alloy:latest run --server.http.listen-addr=0.0.0.0:12345 --storage.path=/var/lib/alloy/data /etc/alloy/config.alloy
```

### (optional) To mount a network drive
<!-- Here the username is a MUST -->
docker volume create --driver local --opt type=cifs --opt device=//<IP>/AKS-Dev-Logs --opt o=username=test selise-dev-log



In the `config.alloy`

```
logging {
  level  = "info"
  format = "logfmt"
}

livedebugging {
  enabled = true
}

local.file_match "tmp" {
  path_targets = [{"__path__" = "/log-root/**/*.log"}]
  sync_period = "1s"
}


loki.source.file "logs" {
  targets    = local.file_match.tmp.targets
  forward_to = [loki.echo.example.receiver]
}

loki.echo "example" { }
```
