FROM ubuntu:16.04

# Never prompts the user for choices on installation/configuration of packages
ENV DEBIAN_FRONTEND noninteractive
ENV TERM linux

# Installing packages
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list

RUN apt-get update && apt-get install -y \
  mysql-server \
  git \
  maven \
  mongodb-org \
  openjdk-8-jdk \
  curl \
  nano \
  awscli \
  netcat \
  && mkdir /u && mkdir /u/apps && cd /u/apps && git clone https://github.com/Easthy/debezium-embedded.git \
  && cd /u/apps/debezium-embedded/mysql && mvn clean install \
  && cd /u/apps/debezium-embedded/mongo && mvn clean install \
  && cd /u/apps && git clone https://github.com/marcusberro/mongodb-replicaset.git

# Configuring aws
RUN mkdir ~/.aws
COPY conf/credentials ~/.aws/credentials

# Enabling binlog
COPY conf/mysql.cnf /etc/mysql/conf.d/mysql.cnf
RUN chmod 0444 /etc/mysql/conf.d/mysql.cnf

# Copy query
COPY query/mongo-create-user.js /mongo-create-user.js

# RUN container
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
