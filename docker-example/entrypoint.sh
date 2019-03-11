#!/usr/bin/env bash

# Move aws credentials files
mv /credentials ~/.aws/credentials

# Start MySQL
service mysql start
mysql -u root -e "GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT, USAGE ON *.* TO 'debezium' IDENTIFIED BY 'dbz'";
mysql -u root -e "CREATE database testdb; use testdb; CREATE TABLE payments(id serial primary key, name text, sum_usd double precision); ";
mysql -u root -e "use testdb; CREATE TABLE users(id serial primary key, username text, created date); ";


# Start Mongo
cd /u/apps/mongodb-replicaset/03-enable-auth-replset
bash stop-cluster.sh
bash start-cluster.sh
bash start-replication.sh

# Prevent from exiting
tail -f '/dev/null'