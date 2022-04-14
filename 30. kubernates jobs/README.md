# Purpose
Job in kubernates allows us to run a container that does it's job a single time and then stops. A container created using job won't restart when it finish it's work.

An example of where a job might be useful is that suppose we have some data stored somewhere and we need to export it somewhere. We can do this using a job.

# Basics
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

# Running a job multiple time
### We can run a job multiple times using `completions` spec
`kubectl create -f multi_completion_job.yaml`
Here the pod will run 5 times. It will run one after another.

# Running a job multiple times in parallel
### We can run a job multiple time and limit how many pods should be up at the same time using the `parallelism` spec
`kubectl create -f multi_completion_parallel_job.yaml`

### We can verify that the job is running multiple pod at the same time using
`kubectl get pods`

# Limiting the time allowed for a job to run
### We can limit how long a job has to complete by using the `activeDeadlineSeconds`, we can also set how many times a job can retry by using the `backoffLimit` field
`kubectl create -f time_limited_job.yaml`

### Use this to see the pod terminating when time is up
`kubectl get pods`

# Deleting
`kubectl delete job <job_name>`

`kubectl delete job <job_name> --cascade=false`
# Reference
[https://kubernetes.io/docs/concepts/workloads/controllers/job](https://kubernetes.io/docs/concepts/workloads/controllers/job)