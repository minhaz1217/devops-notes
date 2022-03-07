## Build the image using 
`docker build -t i_go .`


## Run a container using this image
`docker run -p 3000:3000 -it --rm i_go`

## Now curl to verify the container is working.
`curl localhost:3000` 

or

 `curl localhost:3000/health`