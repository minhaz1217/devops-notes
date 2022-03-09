# Redis docker

## At first we'll create a network
`sudo docker network create redis_network`

## Then we'll create a redis container on this network

`sudo docker run --network redis_network --name redis -dit -v $HOME/redis/data:/data redis redis-server --save 60 1 --loglevel warning`

## Now we'll connect to this redis server using redis cli from another docker
`sudo docker run -it --network redis_network --rm redis redis-cli -h redis`

## Set key on this redis
`SET mykey "hello"`

## Get key

`GET mykey`

## To verify that this cli is connected to the same radis we started before, stop the previous redis using this on the host machine

`sudo docker stop redis`

## Now try to get the same key again run this in the redis CLI
`GET mykey`

It will throw an error `Error: Server closed the connection`

## Now in the host machine start the previous server

`sudo docker start redis`

## Now try to get the key again in the redis CLI
`GET mykey`

Now it will succeed.