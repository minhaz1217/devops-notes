# Purpose
Here we deploy a redis pod and a microservice pod and a service that binds to the redis pod. The microservice pod communicates to the redis pod via FQDN of the service.

We check it by going into another pod and calling the microservice ip.