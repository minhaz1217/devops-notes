## To build this use
`docker-compose build`

## To run this use
`docker-compose up`


## Exect into a container 
`docker exec -it redis_1 bash`

## Run benchmark to get bench mark of a single redis
`redis-benchmark -q`

## T0 get the benchmark of the cluster we can exec into the proxy 
`docker exec -it envoy_proxy`

## And run this command
`redis-benchmark -t set -n 1000000 -r 100000000`

## References
[http://dmitrypol.github.io/redis/2019/03/18/envoy-proxy.html](http://dmitrypol.github.io/redis/2019/03/18/envoy-proxy.html)

[https://fr33m0nk.medium.com/migrating-to-redis-cluster-using-envoy-93a87ae79dc3](https://fr33m0nk.medium.com/migrating-to-redis-cluster-using-envoy-93a87ae79dc3)

[https://blog.devgenius.io/redis-topologies-d9e16a7fa8e0](https://blog.devgenius.io/redis-topologies-d9e16a7fa8e0)

[https://www.lhsz.xyz/read/envoyproxy-1.14.1-en/a40ff5f79fdc9892.md#config-network-filters-redis-proxy](https://www.lhsz.xyz/read/envoyproxy-1.14.1-en/a40ff5f79fdc9892.md#config-network-filters-redis-proxy)

[https://betterprogramming.pub/migrate-from-standalone-redis-to-redis-cluster-f45b219330a3](https://betterprogramming.pub/migrate-from-standalone-redis-to-redis-cluster-f45b219330a3)

[https://redis.io/docs/manual/scaling/](https://redis.io/docs/manual/scaling/)