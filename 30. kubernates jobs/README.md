# Purpose
Job in kubernates allows us to run a container that does it's job a single time and then stops. A container created using job won't restart when it finish it's work.

An example of where a job might be useful is that suppose we have some data stored somewhere and we need to export it somewhere. We can do this using a job.

## Basics
### Create a job using
`kubectl create -f basic_job.yaml`

### See that the pod is up using
`kubectl get pods`

### Get log that that pod using
`kubectl logs <pod_name>`
This pod will disappear after 2 mins.  

### Get jobs using
`kubectl get job`

### Describe a job using
`kubectl describe job <job_name>`

Notice that after the job is done it will show `Completed` when using describe. After that we can get the pods and see that the pod that the job created has status `Completed`