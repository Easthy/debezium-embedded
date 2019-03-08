#!/usr/bin/env bash

# Start MySQL
service mysql start
mysql -u root -e "GRANT SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT, USAGE ON *.* TO 'debezium' IDENTIFIED BY 'dbz'";
mysql -u root -e "CREATE database opencart; use opencart; CREATE TABLE oc_product(id int, name text)";


# Start Mongo
cd /u/apps/mongodb-replicaset/01-simple-replset && bash stop-cluster.sh && bash start-cluster.sh && bash start-replication.sh
mongo --port 27017 < '/mongo-create-user.js'


# sudo docker build /home/tolik/u/apps/debezium/docker-example/ --tag=debezium --no-cache
# sudo docker run debezium
# 
# sudo docker exec -it 7e3916df4bb6 /bin/bash && cd /u/apps/debezium-embedded/mongo && mvn exec:java
# sudo docker exec -it 7e3916df4bb6 /bin/bash && cd /u/apps/debezium-embedded/mysql && mvn exec:java

