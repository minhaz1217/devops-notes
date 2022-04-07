import time
import redis
from flask import Flask

app = Flask(__name__)
cache = redis.Redis(host='service-redis.default.svc.cluster.local', port=6379)

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
    count = get_hit_count()
    return '{}'.format(count)

# Just a health check endpoint
@app.route('/')
def health():
    return "OK - microservice1"