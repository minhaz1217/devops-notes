# Dockerfile.production
# The build stage
FROM golang:1.16-buster as builder
WORKDIR /app
COPY . .
RUN go build main.go

FROM golang:1.16-buster
WORKDIR /app
COPY --from=builder /app .
EXPOSE 3000
CMD ["./main"]

# build command
# docker build -t i_go .
# run command
# sudo docker run -it --rm -p 3000:3000 i_go