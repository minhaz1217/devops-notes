CREATE USER 't_user'@'%' IDENTIFIED BY 'password';
grant all privileges on *.* to 't_user'@'%';
flush privileges;