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
cd fluent-bit-config
set configFolder $PWD
```

#### Lunch fluent bit with the configs

```
docker run -dti --name fluent-bit --network fluent-bit_seq -v C:/Log:/log-root/ -v ${configFolder}:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit -c /fluent-bit/etc/fluent-bit.yml
```
docker run -dti --name fluent-bit-selise --network fluent-bit_seq --mount source=selise-dev-log,target=/log-root,readonly -v ${configFolder}:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit -c /fluent-bit/etc/fluent-bit.yml

docker run -ti --rm --network fluent-bit_seq -v Z:/business-pcx/dev-business-pcx/PCXWebService/:/log-root/ nginx

docker run -dti --name fluent-bit-selise --network fluent-bit_seq -v ${configFolder}:/fluent-bit/etc cr.fluentbit.io/fluent/fluent-bit -c /fluent-bit/etc/fluent-bit.yml

docker run -ti --rm --network fluent-bit_seq --mount source=selise-dev-log,target=/log-root,readonly nginx


<!-- Here the username is a MUST -->
docker volume create --driver local --opt type=cifs --opt device=//10.30.65.6/AKS-Dev-Logs --opt o=username=test selise-dev-log



In the `fluent-bit.yml`

```
  outputs:
    - name: loki
      host: loki
      port:   3100
      labels: agent=fluent-bit
      match: '*'
```
