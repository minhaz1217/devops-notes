# Purpose
Here I will install mongo and set it up in a way where an user can only read and write a single collection or multiple collection but not all.

As a result it will increase security of the db.

# Steps

### Install mongodb
```
docker run -dit --name mongo -p 17017:27017 -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=mongoAdmin33 mongo
```
### Go into the docker container's mongosh
```
docker exec -it mongo bash -c "mongosh mongodb://admin:mongoAdmin33@localhost:27017/?authSource=admin"
```
output -
```
test>
```

### Optional - Disable telemetry
```
disableTelemetry()
```


### Use this command and see that all the dbs are visible
```
show dbs;
```
It should show 3 collections like this -
```
admin    102 kB
config  12.3 kB
local   73.7 kB
```

### Switch to a db using
```
use appleCollection;
```
output -
```
switched to db appleCollection
appleCollection>
```

### Insert some data
```
db.apples.insertMany([
    {
        title: "Green Apple"
    },
    {
        title: "Red Apple"
    },
    {
        title: "Black Apple"
    }
])
```

output - 
```
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId("658893c3b2913cd097ebfd7c"),
    '1': ObjectId("658893c3b2913cd097ebfd7d"),
    '2': ObjectId("658893c3b2913cd097ebfd7e")
  }
}
```
### Create an user and give him read write access for only this collection
```
db.createUser(
   {
     user: "apple_admin",
     pwd: "apple_admin_pass",
     roles: [ "readWrite", "dbAdmin" ]
   }
)
```
It should say
```
{ ok: 1 }
```
### Exit from the current mongosh using
```
exit
```

### Login into mongosh using the new apple admin account
```
docker exec -it mongo bash -c "mongosh mongodb://apple_admin:apple_admin_pass@localhost:27017/?authSource=appleCollection"
```
Please notice that we are using `appleCollection` as the auth source.

### Now use the command to see dbs;
```
show dbs;
```
Only one db should be visible.
```
appleCollection  41 kB
```

### To create an user and give him access to multiple dbs use this
```
use admin
db.createUser(
   {
     user: "multiAdmin",
     pwd: "multiAdminPass",
     roles:
       [
         { role: "readWrite", db: "config" }, 
         { role: "readWrite", db: "appleCollection" }
       ]
   }
)
```

### Now exit and login to that user using
```
exit
docker exec -it mongo2 bash -c "mongosh mongodb://multiAdmin:multiAdminPass@localhost:27017/?authSource=admin"
```

### See the dbs and notice that this user can only see 2 dbs;
```
show dbs;
```

### To remove an user use this
```
use admin;
db.dropUser("multiAdmin", {w: "majority", wtimeout: 5000});
```