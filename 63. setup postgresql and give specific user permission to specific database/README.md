# Purpose
I'll setup a postgresql db using docker and give specific user permission to access only specific database.

# Steps

### Run postgres
```
docker run --name postgres2 -p 15432:5432 -e POSTGRES_USER=rootUser -e POSTGRES_PASSWORD=rootPassword -dit postgres:latest
```

### Connect to the postgres instance using psql
```
docker exec -it postgres2 bash -c "psql -U rootUser"
```

### Create the database that this user will have access to
```
CREATE DATABASE apple_collection;
```

### Switch to that database
```
\c apple_collection
```
### Create a schema that our new user will have access to.
```
CREATE SCHEMA fruits;
```

### Create a table in the db in the schema
```
CREATE TABLE "fruits"."apples" ("name" varchar(255));
```

### Enter some data in the table
```
INSERT INTO "fruits"."apples"("name") VALUES ('red apple');
INSERT INTO "fruits"."apples"("name") VALUES ('green apple');
INSERT INTO "fruits"."apples"("name") VALUES ('black apple');
```

### Query the data to see everything is working
```
SELECT * FROM "fruits"."apples";
```

### Create a new role for the db
```
CREATE ROLE "applecollectionadmin" NOINHERIT LOGIN ENCRYPTED PASSWORD 'appleCollectionAdmin_pass33';
```
output -
```
CREATE ROLE
```

### Grant the user permission to that specific schema, this won't give access to already existing tables. 
```
GRANT USAGE ON SCHEMA fruits TO applecollectionadmin;
```

### This will give access to all tables.
```
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA fruits TO applecollectionadmin;
```

### Grant the role we created access to the specific database this won't give access to already created tables or schemas.
```
GRANT ALL PRIVILEGES ON DATABASE appleCollection TO applecollectionadmin;
```
output -
```
GRANT
```

### Now exit from the root user
```
exit
```

### Login as the newly created user
```
docker exec -it postgres2 bash -c "psql -U applecollectionadmin -d apple_collection"
```
### See that query is working
```
SELECT * FROM "fruits"."apples";
```



## Extra commands

### Switch database
```
\c dvdrental
```

### See tables of the connected database
```
\dt
```

### List roles
```
\du;
```

### List databases using this
```
\l
```
or
```
SELECT datname FROM pg_database;
```

### List schema using this
```
\dn;
```