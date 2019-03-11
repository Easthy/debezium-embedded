## Последовательность запуска
1. Собрать образ Docker `docker build /path/to/debezium/docker-example/ --tag=debezium --no-cache`  
2. Запустить конейтер `docker run debezium --name debezium`  
3. Подключиться к контейнеру Docker:  
`docker exec -it ba6f9d3f1e05 /bin/bash`, где ba6f9d3f1e05 - id запущенного контейнера, к-й можно получить выполнив команду `docker ps`  
4. Запуск debezium в контейнере Docker  
4.1 Debezium для MySQL  
4.1.1 Подключиться к контейнеру Docker и выполнить `cd /u/apps/debezium-embedded/mysql && mvn exec:java`  
4.1.2 Подключиться в новом терминале к контейру Docker, выполнить `mysql -u root`, внести изменения в таблицы payments, users - данные будут отправлены в stream kinesis.  
4.2 Debezium для MongoDB  
4.2.1 Подключиься к контейнеру Docker и выполнить: `cd /u/apps/debezium-embedded/mongo && mvn exec:java`    
4.2.2 Подключить в новом терминале к контейру Docker, выполнить `mongo --port 27023`, внести изменения в коллекцию game_events (имя БД test, user: dbAdmin, pass: dbAdmin) - данные будут отправлены в stream kinesis.

При отправке данных в терминале выводятся подобные сообщения:  
>2019-03-11 10:52:48,913 INFO   MySQL|kinesis-mysql|binlog  4 records sent during previous 00:00:51.5, last recorded offset: {ts_sec=1552301568, file=mysql-bin-log.000001, pos=1452, row=1, server_id=223344, event=2}   [io.debezium.connector.mysql.BinlogReader]  

>2019-03-11 15:12:02,019 INFO   MongoDB|test|task  1 records sent for replica set 'rs', last offset: {sec=1552317121, ord=1, h=5372230464836817420}   [io.debezium.connector.mongodb.MongoDbConnectorTask]

#### Настройки aws  
Файл `debezium-embedded/docker-example/conf/credentials/` должен содержать параметры aws_access_key_id, aws_secret_access_key. Пример содержимого:  

[default]
aws_access_key_id = XXXIAJRXDAJDXXXXLYXXX  
aws_secret_access_key = XX31Yj7XXXDC8oT7XXX6pXXXbcgWVZ+e9G/X7X  
region = eu-central-1  
