# Purpose
At first I needed a quick api. Then I wanted to make the image smaller so that the download size is reduced.
Disclaimer:

# Steps

## API code setup

The api is very simple. It takes hit and returns the path.

### Create a `main.go` file in `/api` folder.
```
package main
import (
	"fmt"
	"log"
	"net/http"
)
func main() {
	fmt.Println("App Starting...")
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":3000", nil))
}
func handler(w http.ResponseWriter, r *http.Request) {
	simpleOutput := fmt.Sprintf("Got hit from: %s", r.URL.Path[1:])
	fmt.Println(simpleOutput)
	fmt.Fprintf(w, simpleOutput)
}
```

## First - basic. Image size `839.24mb`

### Create a `Dockerfile` using this config.
Here I just use the `go run` command in the docker container.

```
FROM golang:1.15.7-buster

WORKDIR /app
COPY . .
ENTRYPOINT ["go", "run", "api/main.go"]
```
### Now build the image using
```
docker build -t i_go_basic .
```

### Now run create a container using the image
```
docker run -it --rm -p 3001:3000 --name=go-api-basic i_go_basic
```

### Hit with a curl request.
```
curl localhost:3001/status
```

## Second - multistage. Image size `868.58mb`
Here I use multistage and use `go build`

```
# The build stage
FROM golang:1.16-buster as builder
WORKDIR /app
COPY . .
RUN go build -o go-api /app/api/main.go

# The run stage
FROM golang:1.16-buster
WORKDIR /app
COPY --from=builder /app/go-api .
EXPOSE 3000
CMD ["./go-api"]
```
### Now build the image using
```
docker build -t i_go_basic_build .
```

### Now run create a container using the image
```
docker run -it --rm -p 3002:3000 --name=go-api-basic-build i_go_basic_build
```

### Hit with a curl request.
```
curl localhost:3002/status
```


## Third - multistage but with `debian` as base. Image size `80.94mb`
Here I use multistage and use `go build` and also use a `debian` slim image as base.

```
# The build stage
FROM golang:1.16-buster as builder
WORKDIR /app
COPY . .
RUN go build -o go-api /app/api/main.go

# The run stage
FROM debian:stable-slim
WORKDIR /app
COPY --from=builder /app/go-api .
EXPOSE 3000
CMD ["./go-api"]
```
### Now build the image using
```
docker build -t i_go_basic_build_debian .
```

### Now run create a container using the image
```
docker run -it --rm -p 3003:3000 --name=go-api-basic-build-debian i_go_basic_build_debian
```

### Hit with a curl request.
```
curl localhost:3003/status
```


## Fourth and final - multistage from `scratch`. Image size `6.13mb`
Here I use multistage and use `go build` but use `scratch` as base.

```
# The build stage
FROM golang:1.16-buster as builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o go-api /app/api/main.go

# The run stage
FROM scratch
WORKDIR /app
COPY --from=builder /app/go-api .
EXPOSE 3000
CMD ["./go-api"]
```
### Now build the image using
```
docker build -t i_go_basic_build_scratch .
```

### Now run create a container using the image
```
docker run -it --rm -p 3004:3000 --name=go-api-basic-build-scratch i_go_basic_build_scratch
```

### Hit with a curl request.
```
curl localhost:3004/status
```

## Reset
### Removing all the images
```
docker image rm i_go_basic
docker image rm i_go_basic_build
docker image rm i_go_basic_build_debian
docker image rm i_go_basic_build_scratch
```