#!/usr/bin/env bash

# Start MySQL
service mysql start
mysql -u root -e "GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT, USAGE ON *.* TO 'debezium' IDENTIFIED BY 'dbz'";
mysql -u root -e "CREATE database opencart; use opencart; CREATE TABLE oc_product(id serial primary key, name text)";


# Start Mongo
USER mongodb
cd /u/apps/mongodb-replicaset/01-simple-replset
bash stop-cluster.sh
bash start-cluster.sh

# Create user
USER root
: ${MONGO_HOST:=localhost}
: ${MONGO_PORT:=27017}

until nc -z $MONGO_HOST $MONGO_PORT
do
    echo "Waiting for Mongo ($MONGO_HOST:$MONGO_PORT) to start..."
    sleep 0.5
done

bash start-replication.sh
mongo --port 27017 < '/mongo-create-user.js'

tail -f '/dev/null'