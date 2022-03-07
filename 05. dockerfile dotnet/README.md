## Build the image using 
`docker build -t i_dotnet .`


## Run a container using this image
`docker run -p 80:80 i_dotnet`

## Now curl to verify the container is working.
`curl localhost:80` 

or

 `curl localhost:80/health`