## Install docker and docker compose
```
wget https://raw.githubusercontent.com/minhaz1217/linux-configurations/master/bash/03.%20installing%20docker/install_docker_and_docker_compose.sh

bash install_docker_and_docker_compose.sh
```

## Create a app.py file using
`nano app.py`

## Paste these and save the file
```
import time
import redis
from flask import Flask

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route('/')
def hello():
    count = get_hit_count()
    return 'Hello World! I have been seen {} times.\n'.format(count)
```

## Create a file requirements.txt using
`nano requirements.txt`

## Paste and save these
```
flask
redis
```

## Create a Dockerfile using
`nano Dockerfile`

## Paste and save these
```
# syntax=docker/dockerfile:1
FROM python:3.7-alpine
WORKDIR /code
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000
COPY . .
CMD ["flask", "run"]
```

## Create a docker-compose.yml using
`nano docker-compose.yml`

## Paste and save these
```
version: "3.9"
services:
  web:
    build: .
    ports:
      - "8000:5000"
  redis:
    image: "redis:alpine"
```


## Start the containers using
`sudo docker-compose up -d`

## Send request to check that the server is working
`curl localhost:8000`


## Reference
https://docs.docker.com/compose/gettingstarted/#step-2-create-a-dockerfile