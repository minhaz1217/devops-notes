# Purpose
Installing and enabling timescaledb in a pre existing postgres db.

I'm running a debian based system (postgres with docker). So my commands will be debian/apt based.

# Steps

### bash into the docker
`docker exec -it postgres bash`

## Step 1 - Installing the extension
### Add common needed things.
`apt install gnupg postgresql-common apt-transport-https lsb-release wget`

Enter 2 to keep the already installed postgres version

### Run the PostgreSQL repository setup script
`/usr/share/postgresql-common/pgdg/apt.postgresql.org.sh`

### Add the TimescaleDB third party repository
`echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" | tee /etc/apt/sources.list.d/timescaledb.list`

<!-- original command with the sudo
echo "deb https://packagecloud.io/timescale/timescaledb/debian/ $(lsb_release -c -s) main" | sudo tee /etc/apt/sources.list.d/timescaledb.list 
-->

### Install Timescale GPG key
`wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | apt-key add -`

<!-- original command with the sudo 
wget --quiet -O - https://packagecloud.io/timescale/timescaledb/gpgkey | sudo apt-key add - 
-->

### Update your local repository list
`apt update`


### Install the extension
`apt install timescaledb-2-postgresql-14 -y`

Remember to restart docker
`docker restart postgres`

## Enabling TimescaleDB

### Connect to the postgres using psql
`psql -U minhaz -h localhost`


### Create a database to enable the extension on it
`CREATE database tsdb;`

### Connect to the database.
`\c tsdb`

### Create the extension
`CREATE EXTENSION IF NOT EXISTS timescaledb;`

### Now exit and restart the docker container using
`docker restart postgres`


### After the docker container is up connect to it 
`docker exec -it postgres bash`

### Connect to our created database
`psql -U minhaz -h localhost -d tsdb`

### Use this command to find out the enabled extensions
`\dx`


## If the extension isn't enabled, it will show if it isn't follow the next steps.

### Exit the psql using
`exit`


### Now we need to edit a file. 
`nano /var/lib/postgresql/data/pgdata/postgresql.conf`

### if nano isn't installed install nano using
`apt install nano`

### After the file opens, find the `shared_preload_libraries `, you can use CTRL + w to search the file inside nano.

### Add `timescaledb` as preloaded libraries. After edit it should look like this.
`shared_preload_libraries = 'timescaledb'`

### Now exit the bash and restart the docker
`docker restart postgres`

### Get into the postgres when the container is up again.
`docker exec -it postgres bash`

### Log into psql
`psql -U minhaz -h localhost -d tsdb`

### Use this to enable the extension.
`psql -U minhaz -h localhost -d tsdb`

### Make sure that the extension is enabled using.
`\dx`
