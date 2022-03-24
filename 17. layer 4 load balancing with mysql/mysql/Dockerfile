FROM mysql
# RUN apt update 
# RUN apt install tcpdump -y
COPY custom.cnf /etc/mysql/conf.d/custom.cnf
COPY my.cnf /etc/mysql/my.cnf
COPY users.sql /docker-entrypoint-initdb.d/users.sql
