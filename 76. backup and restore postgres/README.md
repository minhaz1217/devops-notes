
## To take backup of all the databases use this
```
pg_dumpall -U minhaz -f backup_file_all.sql
```
Now you can copy that file into another location
```
cp ./backup_file_all.sql /var/lib/postgresql/data/backup_file_all.sql
```

pg_dump --host localhost --port 5432 --username postgres --format plain --verbose --file "<abstract_file_path>" --table public.tablename dbname

pg_dumpall -U username -f backup_file.sql

pg_restore -U username -d new_database_name -1 backup_file.sql


<!-- 
psql -U minhaz -d postgres

\list or \l: list all databases
\c <db name>: connect to a certain database
\dt: list all tables in the current database using your search_path
\dt *.: list all tables in the current database regardless your search_path 
-->
