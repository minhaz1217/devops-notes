



## Steps

### Run this to start a docker container.
```
docker run -dit --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=mysqlAdminPass33 mysql:latest
```

### Login into the mysql
```
docker exec -it mysql bash -c "mysql -pmysqlAdminPass33"
```

### See users
```
SELECT USER(),CURRENT_USER();
```

output 
```
+----------------+----------------+
| USER()         | CURRENT_USER() |
+----------------+----------------+
| root@localhost | root@localhost |
+----------------+----------------+
1 row in set (0.00 sec)
```

### See databases
```
show databases;
```
output - 
```
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0.01 sec)
```


### Create a new user
```
CREATE USER 'appleCollectionAdmin'@'localhost' IDENTIFIED BY 'appleCollectionAdminPass';
```


Output
```
Query OK, 0 rows affected (0.03 sec)
```



### See the privilege of this user
```
select * from information_schema.user_privileges where GRANTEE="'appleCollectionAdmin'@'localhost'";
```
output - 
```
+------------------------------------+---------------+----------------+--------------+
| GRANTEE                            | TABLE_CATALOG | PRIVILEGE_TYPE | IS_GRANTABLE |
+------------------------------------+---------------+----------------+--------------+
| 'appleCollectionAdmin'@'localhost' | def           | USAGE          | NO           |
+------------------------------------+---------------+----------------+--------------+
1 row in set (0.00 sec)
```

### Grant this user access to appleCollection
```
GRANT ALL PRIVILEGES ON appleCollection.* TO 'appleCollectionAdmin'@'localhost';
FLUSH PRIVILEGES;
```

### Exit from the root user
```
exit
```

### Login with the new user
```
docker exec -it mysql bash -c "mysql -uappleCollectionAdmin -pappleCollectionAdminPass"
```

### See the grants of this user
```
show grants;
```
output -
```
+-----------------------------------------------------------------------------------+
| Grants for appleCollectionAdmin@localhost                                         |
+-----------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `appleCollectionAdmin`@`localhost`                          |
| GRANT ALL PRIVILEGES ON `appleCollection`.* TO `appleCollectionAdmin`@`localhost` |
+-----------------------------------------------------------------------------------+
2 rows in set (0.00 sec)
```
Now this user has access to only appleCollection database


### Create the db
```
CREATE DATABASE appleCollection;
```
output -
```
Query OK, 1 row affected (0.03 sec)
```

### Now try to create another db, it will fail
```
CREATE DATABASE appleCollection2;
```
output -
```
ERROR 1044 (42000): Access denied for user 'appleCollectionAdmin'@'localhost' to database 'appleCollection2'
```