import time
import redis
from flask import Flask
import requests

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

# This route will send the number of hits.
@app.route('/get-hit-count')
def hello():
    url = "http://microservice1:5000/get-hit-count"
    r = requests.get(url = url)
    print(r.json())
    return str(r.json()) + "\n"

# Just a health check endpoint
@app.route('/')
def health():
    return "OK - microservice2"
