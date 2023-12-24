# Purpose
Here I will install mongo and set it up in a way where an user can only read and write a single collection or multiple collection but not all.

As a result it will increase security of the db.

# Steps

### Install mongodb
```
docker run -dit --name mongo -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=mongoAdmin33 mongo
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
![show dbs output](<images/01. show dbs output.png>)

### Switch to a db using
```
use appleCollection;
```
output -
```
switched to db appleCollection
appleCollection>
```
![after changing the db](<images/02. after changing db.png>)

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
![after inserting data](<images/03. after data inserted.png>)

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
![after creating user](<images/04. after creating user.png>)

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
![show dbs output](<images/05. show dbs using different user.png>)


### Select data from this db.
```
db.apples.find({});
```
output - 
```
[
  { _id: ObjectId("658893c3b2913cd097ebfd7c"), title: 'Green Apple' },
  { _id: ObjectId("658893c3b2913cd097ebfd7d"), title: 'Red Apple' },
  { _id: ObjectId("658893c3b2913cd097ebfd7e"), title: 'Black Apple' }
]
```
![find data](<images/06. db find command.png>)


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
docker exec -it mongo bash -c "mongosh mongodb://multiAdmin:multiAdminPass@localhost:27017/?authSource=admin"
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