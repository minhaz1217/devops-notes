# Purpose
Here we try to solve a problem in distributed system. The problem is leader selection. When we have multiple replicas and we want some task to happen only once (maybe some scheduled task from inside the application) we may need to know who will execute the task in a distributed system. This pose a problem as in a distributed system selecting a leader is a complex task. 

But we can do this easily and reliably using zookeeper. Here we use 3 replicas of our [solution](https://github.com/minhaz1217/Leader-Election-In-A-Distributed-System-Using-ZooKeeper), a nginx load balancer and zookeeper to simulate the solution

# Architecture
Here we implement this architecture

![architecture](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/37.%20zookeeper%20leader%20election%20in%20a%20distributed%20system/images/00.%20testing%20leader%20election%20application.png)

# Steps

## At first we build and run the docker compose file using
`docker-compose up -d --scale leader-election=5`

## To make sure that all our containers are up we can use this
`docker ps -f network=zookeeper-distributed-system --format "{{.ID}}\t{{.State}}\t{{.Status}}\t{{.Names}}"`

![all containers are running](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/37.%20zookeeper%20leader%20election%20in%20a%20distributed%20system/images/01.%20all%20containers%20are%20running.png)
*Notice the container ids

## Now we use curl to see which container is our leader right now
```
for (($i = 0); $i -lt 10; $i++){ 
    curl.exe http://localhost:5001/api/LeaderElection/is-leader
    "" 
}
``` 
![leader is selected](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/37.%20zookeeper%20leader%20election%20in%20a%20distributed%20system/images/02.%20leader%20has%20been%20selected.png)

## Now we restart the current leader container using this
`docker restart 46f0db8f00ee`

## Immediately we'll see that no one is leader
![No one is leader immediately after restart](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/37.%20zookeeper%20leader%20election%20in%20a%20distributed%20system/images/03.%20no%20one%20is%20leader%20after%20restart.png)


## After some time (maybe less than half a second) we can see that the new leader has been selected
![new leader has been selected](https://raw.githubusercontent.com/minhaz1217/devops-notes/master/37.%20zookeeper%20leader%20election%20in%20a%20distributed%20system/images/04.%20new%20leader%20has%20been%20selected.png)


#
# Created By - [Minhazul Hayat Khan](https://github.com/minhaz1217)
