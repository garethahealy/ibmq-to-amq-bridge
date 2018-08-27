#!/usr/bin/env bash

# grab the needed proprietary libs from the MQ container and install locally

docker pull ibmcom/mq:9
docker-compose -f .travis/docker-compose.yml up -d

docker cp local-mq9:/opt/mqm/java/lib/com.ibm.mq.allclient.jar .
docker cp local-mq9:/opt/mqm/java/lib/com.ibm.mq.pcf.jar .

mvn install:install-file -Dfile=com.ibm.mq.allclient.jar -DgroupId=com.ibm.mq -DartifactId=allclient -Dversion=9.0.0 -Dpackaging=jar -B
