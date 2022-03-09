# syntax=docker/dockerfile:1
FROM ubuntu:20.04
RUN apt update
RUN apt update
RUN apt install software-properties-common -y
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt install ansible -y
RUN apt install nano -y
ENTRYPOINT ["tail", "-f", "/dev/null"]

# docker build -t i_docker_ansible .
# docker run -d --name docker_ansible i_docker_ansible