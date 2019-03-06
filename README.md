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
Debezium проверяет измененения в binlog(mysql), oplog(mongo) и отсылает события в kinesis stream записывая в файл значение offset (последнее успешно отправленное событие). Для MySQL дополнительно сохраняются изменения схемы БД в файле history. Пути записи offset и dbhistory определяются в файле pom.xml. Имя kinesis stream задаётся также в файле pom.xml.

После запуска приложения осуществляется первичная синхронизация, которую не рекомендуется прерырвать до её окончания, т.к. это может привести к повторному запуску синхронизации после перезапуска приложения