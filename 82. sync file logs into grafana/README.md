# Purpose

The purpose of this is that we have a file log.txt, our application will write log to this file, we want to send the logs written in this file into grafana.

To achieve this we'll use fluent bit to watch over this file, then we'll send the logs to loki and then query loki from inside grafana.

## Setup loki

```
docker run -dit --name loki -p3100:3100 --network fluent-bit_seq grafana/loki:2.9.2
```

## Setup grafana

```
docker run -dit -p 3000:3000 --network fluent-bit_seq --name grafana -e "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource"  grafana/grafana:latest
```

## Setup fluent bit

### Setup the config folder `fluent-bit-config folder` as the config folder

```
set projectRoot $PWD
```

#### Lunch fluent bit with the configs

```
docker run -dti --name fluent-bit --network fluent-bit_seq -v C:/Log:/log-root/ -v ${projectRoot}/fluent-bit-config:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit -c /fluent-bit/etc/fluent-bit.yml
```

<!-- working copy -->
docker run -dti --name fluent-bit-selise --network fluent-bit_seq --mount source=selise-dev-log,target=/log-root,readonly -vC:/Log:/log-root2:ro -v ${projectRoot}/fluent-bit-config:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit -c /fluent-bit/etc/fluent-bit.yml
<!--  -->


docker run -dti --name fluent-bit-selise --network fluent-bit_seq -vC:/Log:/log-root2:ro -v ${projectRoot}/fluent-bit-config:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit -c /fluent-bit/etc/fluent-bit.yml


### (optional) To mount a network drive
<!-- Here the username is a MUST -->
docker volume create --driver local --opt type=cifs --opt device=//<IP>/AKS-Dev-Logs --opt o=username=test selise-dev-log



In the `fluent-bit.yml`

```
  outputs:
    - name: loki
      host: loki
      port:   3100
      labels: agent=fluent-bit
      match: '*'
```
