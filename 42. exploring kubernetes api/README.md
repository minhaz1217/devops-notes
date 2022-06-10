# Purpose
Here we explore the kubernetes rest api.


## Basics
#### At first use this command to find out the api url
`kubectl cluster-info`


#### Hit the api 
`curl https://kubernetes.docker.internal:6443 -k`

Notice that it is throwing Forbidden status, as it is https request.

#### Use this to expose the api
`kubectl proxy`


#### Now hit the url and get the list of apis
`curl localhost:8001`


## Exploring the batch api

#### Use this to list end points that's under the batch api.
`curl http://localhost:8001/apis/batch`


#### List of things in v1 batch
`curl http://localhost:8001/apis/batch/v1`

#### List of jobs in v1 batch
`curl http://localhost:8001/apis/batch/v1/jobs`

#### To get definition of my-job job
`curl http://localhost:8001/apis/batch/v1/namespaces/default/jobs/my-job`

This will output the same result that we would've gotten had we used  `kubectl get job my-job -o json`

