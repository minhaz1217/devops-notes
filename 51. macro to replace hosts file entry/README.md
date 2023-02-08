# Motivation
In our organization we use host name like "custom-app.our-domain.com" for dev environment. Our microservices recognize that host and accept requests from it. As a result when we want to launch our angular dev environment locally we have to change the *hosts* file and add entry like
`127.0.0.1 custom-app.our-domain.com`

So that when we try to bind to the 4200 port(angular's default port) of "custom-app.our-domain.com" we'll get to our localhost.

But it creates a problem. The problem is that now when our QA or PM team reports a bug or issue or when we have to enter the real dev environment we'll have to comment out our part from the *hosts* file and enter the main dev domain. And when we want to start developing again we'll have to uncomment the entry.

**The solution**
One possible solution is to run a macro in powershell and replace the entry if it was commented then uncomment it, if it was uncommented when comment it. Basically toggle dev domain setup and local domain setup.

### Script
```

```

