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

Mongo всегда считывает oplog primary-сервера.

Для корректной работы с mysql необходимо задать в конфигурационном файле mysql часовой пояс, например `default-time-zone='+00:00'`.

Приложение останавливать `ctrl + c`

