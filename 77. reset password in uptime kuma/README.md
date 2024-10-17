## Purpose

The purpose of this is to reset the password of an uptime kuma installation. The motivation behind this is that I forget my password for the uptime kuma very frequently. So I need to reset them every 4-6 months (⓿_⓿).

### if you are running the uptime kuma in a docker, then at first go inside the container

```
docker exec -it uptime-kuma bash
```

### Install sqlite in the container

```
apt install sqlite
```

### Locate the `kuma.db` file and open it in sqlite

```
sqlite3 /app/data/kuma.db
```

### You can list all the users using this query and note the id

```
SELECT * FROM user;
```

### Run this command to update the password

```
UPDATE user SET password="$2y$10$IWoZl5q9Tvvp1wxROvi4hOul7XP.rfyrvm4xbm7ufVANke1nfvLIu" WHERE id=1;
```

If you want to set a specific password then just go to [this](https://bcrypt-generator.com/) website and generate the bcrypt password. Then put it inside the sql `password="<encrypted_password>"`.

### Now you can just log in to your user account using the password `password`, don't forget to change the password after you log in.

## Reference

1. [https://docs.pikapods.com/apps/uptime-kuma](https://docs.pikapods.com/apps/uptime-kuma)
2. [https://github.com/minhaz1217/devops-notes/tree/master/77.%20reset%20password%20in%20uptime%20kuma](https://github.com/minhaz1217/devops-notes/tree/master/77.%20reset%20password%20in%20uptime%20kuma)

#
# Created By - [Minhazul Hayat Khan](https://github.com/minhaz1217)
