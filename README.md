# Debezium-embedded: mysql -> kinesis, mongo -> kinesis

## Для сборки приложений требуется установить maven
`apt-get install maven`

## Сборка приложения
`mvn clean install`

`mvn clean install -X` (дебаг-режим)

## Запуск приложения
`mvn exec:java`

`mvn exec:java -X` (дебаг-режим)

### Описание
Debezium проверяет измененения в binlog(mysql), oplog(mongo) и отсылает события в kinesis stream записывая в файл значение offset (последнее успешно отправленное событие). Для MySQL дополнительно сохраняются изменения схемы БД в файле history. 

Пути записи offset и dbhistory, имя kinesis stream определяются в файле pom.xml:
`<database.history.file.filename>history.dat</database.history.file.filename>`

`<offset.storage.file.filename>offset.dat</offset.storage.file.filename>`

`<kinesis.stream.name>name</kinesis.stream.name>`

После запуска приложения осуществляется первичная синхронизация, которую не рекомендуется прерырвать до её окончания, т.к. это может привести к повторному запуску синхронизации после перезапуска приложения.

Приложение останавливать `ctrl + c`

#### Mongo
Mongo всегда считывает oplog primary-сервера. Пользователь должен иметь права на чтение БД: `admin` (для считывание oplog), `config` (в случае sharded cluster). 

#### MySQL
Для корректной работы с mysql необходимо задать в конфигурационном файле mysql часовой пояс, например `default-time-zone='+00:00'`.
Пользователь MySQL, используемый debezium, должен иметь следующие права в БД: `SELECT, RELOAD, SHOW DATABASES, REPLICATION SLAVE, REPLICATION CLIENT`.

При запуске приложение устанавливает режим global read lock на время чтения схемы БД и текущей позиции в binlog. В случае когда global read lock запрещён пользователю, коннектор попытается установить блокировку чтения на уровне таблицы (для этого пользователь должен иметь права `LOCK TABLES`). Блокировка на уровне таблицы осуществляется на время чтения схемы и генерации CREATE событий для каждой строки таблицы.
