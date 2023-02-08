# Motivation
In our organization we use host name like "custom-app.our-domain.com" for dev environment. Our microservices recognize that host and accept requests from it. As a result when we want to launch our angular dev environment locally we have to change the hosts file and add entry like
`127.0.0.1 custom-app.our-domain.com`

So that when we try to bind to the 4200 port(angular's default port) of "custom-app.our-domain.com" we'll get to our localhost.

But it creates a problem. TBC.

