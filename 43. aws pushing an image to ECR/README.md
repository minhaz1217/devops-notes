# Purpose
Push an image to the amazon elastic container registry.

# Steps
### Create a repository in ECR
Ours name is demo-repo

### Download aws cli

### Verify that the installation is done successfully using
`aws --version`
### Configure aws cli with your account using
`aws configure`

You may have to create a access key which can be done from `IAM > Users > Your User > Security credentials > Access Keys`

### Login to the aws using
`aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 661025160735.dkr.ecr.us-east-1.amazonaws.com`

### Tag a docker image that you want to push to ECR
`docker tag 62e07344f48a 661025160735.dkr.ecr.us-east-1.amazonaws.com/demo-repo:v1`

### Push to the ECR
`docker push 661025160735.dkr.ecr.us-east-1.amazonaws.com/demo-repo:v1`

# Reference
[https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html](https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html)


#
# Created By - [Minhazul Hayat Khan](https://github.com/minhaz1217)
