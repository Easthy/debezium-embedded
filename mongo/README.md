## Параметры
`connect.max.attempts` - максимальное кол-во попыток подключения выполняемых коннектором. По исчерпанию количества попыток приложение продолжит выполняться, но попыток подключения приниматься больше не будет  
`connect.backoff.max.delay.ms` - максимальная задержка между попытками подключения. Применяется с connect.max.attempts/2 попытки подключения  
`connect.backoff.initial.delay.ms` - начальное значение задержки между попытками подключения. Значение растёт до попытки connect.max.attempts/2 в геометрической прогрессии  

## Падение коннектора mongo, после которого прекращается отсылка данных в kinesis, выглядит в логах следующим образом:
> 2019-03-14 18:31:58,340 ERROR Error while attempting to read from oplog on 'rs/localhost:27023,localhost:27024,localhost:27025': Query failed with error code 11600 and error message 'interrupted at shutdown' on server localhost:27023 [io.debezium.connector.mongodb.Replicator]  
> 2019-03-14 18:32:28,341 ERROR Error while attempting to read from oplog on 'rs/localhost:27023,localhost:27024,localhost:27025': Timed out after 30000 ms while waiting to connect.  
> 2019-03-14 18:32:39,564 ERROR Error while reading the 'shards' collection in the 'config' database: Timed out after 30000 ms while waiting for a server...  
> 2019-03-14 18:36:18,344 INFO Unable to connect to primary node of 'rs/localhost:27023,localhost:27024,localhost:27025' after attempt #8 (2 remaining) [io.debezium.connector.mongodb.ConnectionContext]  
> 2019-03-14 18:38:18,345 ERROR Replicator for replica set rs failed [io.debezium.connector.mongodb.Replicator]  
> 2019-03-14 18:38:18,345 INFO Stopping MongoDB task [io.debezium.connector.mongodb.MongoDbConnectorTask]  
> 2019-03-14 18:38:18,346 INFO Stopped MongoDB replication task by stopping 1 replicator threads [io.debezium.connector.mongodb.MongoDbConnectorTask]  
> 2019-03-14 18:38:19,313 INFO Stopping MongoDB connector [io.debezium.connector.mongodb.MongoDbConnector]  
> 2019-03-14 18:38:19,316 ERROR Error while trying to run connector class 'io.debezium.connector.mongodb.MongoDbConnector' [io.debezium.embedded.EmbeddedEngine]  
> 2019-03-14 18:38:19,316 ERROR Error while trying to get information about the replica sets [io.debezium.connector.mongodb.ReplicaSetMonitorThread]  
