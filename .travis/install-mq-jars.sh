#!/usr/bin/env bash

# grab the needed proprietary libs from the MQ container and install locally

docker pull ibmcom/mq:8
docker-compose -f .travis/docker-compose.yml up -d

docker cp local-mq8:/opt/mqm/java/lib/com.ibm.mq.allclient.jar .
docker cp local-mq8:/opt/mqm/java/lib/com.ibm.mq.pcf.jar .

mvn install:install-file -Dfile=com.ibm.mq.allclient.jar -DgroupId=com.ibm.mq -DartifactId=allclient -Dversion=8.0.0.6 -Dpackaging=jar -B
