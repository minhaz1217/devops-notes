# Purpose
**CronJob** is a resource of kubernates that executes a job periodically or once in the future

## Basics
### Creating a CronJob
`kubectl create -f basic_cronjob.yaml`
This will run a pod every 15 min.

### Get list of cron jobs
`kubectl get cronjobs`

`kubectl get cj`

### Describe a cronjob using
`kubectl describe cj basic-cronjob`

### Inspect pods to see the job is running
`kubectl get pods`



## Time limited cron jobs
### If we need a job to run within a thrash hold limit(there might be a slight delay when the container is created and the job is run) we can use the `startingDeadlineSeconds` field in the spec

`kubectl create -f time_limited_cronjob.yaml`

If the job didn't run by the limit set in `startingDeadlineSeconds` field, it will be shown as failed.