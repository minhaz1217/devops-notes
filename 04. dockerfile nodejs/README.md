## Build the docker image by running
`docker build -t nodejs_image .`

## Start a container by running
`docker run -p 8080:8080 nodejs_image`

## Now check by requesting localhost:8080
`curl localhost:8080`

# Dockerfile basics

## FROM
Using `FROM` we define our base image.

## WORKDIR

## COPY

## RUN

## EXPOSE

## START