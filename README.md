[![Build Status](https://travis-ci.org/garethahealy/ibmq-to-amq-bridge.svg?branch=master)](https://travis-ci.org/garethahealy/ibmq-to-amq-bridge)
[![Coverage](https://sonarqube.com/api/badges/measure?key=com.garethahealy.ibmq-to-amq-bridge:ibmq-to-amq-bridge&metric=coverage)](https://sonarcloud.io/dashboard?id=com.garethahealy.ibmq-to-amq-bridge%3Aibmq-to-amq-bridge )
[![Release Version](https://img.shields.io/maven-central/v/com.garethahealy.ibmq-to-amq-bridge/ibmq-to-amq-bridge.svg?maxAge=2592000)](https://mvnrepository.com/artifact/com.garethahealy.ibmq-to-amq-bridge/ibmq-to-amq-bridge)
[![License](https://img.shields.io/hexpm/l/plug.svg?maxAge=2592000)]()

# ibmq-to-amq-bridge
Simple example showing IBM MQ9 -> AMQ via a Apache Camel bridge

## Dependency's
The IBM MQ Java dependencies have to be downloaded from the IBM website. The following link includes instructions on how to do this:
- https://www-01.ibm.com/support/docview.wss?uid=swg21683398

And the following is a direct link (at time of writing) to the download:
- http://www-01.ibm.com/support/docview.wss?uid=swg21995100

Once you have downloaded the zip/tar and expanded, the JARs need to be installed via Maven.
The below dependency is a core requirement:

    mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=JavaSE/com.ibm.mq.allclient.jar -DgroupId=com.ibm.mq -DartifactId=allclient -Dversion=8.0.0.6 -Dpackaging=jar

These are optional and not directly used by the code, but it is suggested to install for safety:

    mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=JavaSE/providerutil.jar -DgroupId=com.ibm.mq -DartifactId=providerutil -Dversion=9.0.0 -Dpackaging=jar
    mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=JavaSE/jms.jar
    mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=JavaSE/fscontext.jar -DgroupId=com.ibm.mq -DartifactId=fscontext -Dversion=9.0.0 -Dpackaging=jar
    mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=JavaSE/com.ibm.mq.traceControl.jar -DgroupId=com.ibm.mq -DartifactId=traceControl -Dversion=9.0.0 -Dpackaging=jar
    mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=JavaSE/JSON4J.jar -DgroupId=com.ibm.mq -DartifactId=JSON4J -Dversion=9.0.0 -Dpackaging=jar
    mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=OSGi/com.ibm.mq.osgi.allclientprereqs_8.0.0.6.jar -DgroupId=com.ibm.mq.osgi -DartifactId=allclientprereqs -Dversion=9.0.0 -Dpackaging=jar
    mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=OSGi/com.ibm.mq.osgi.allclient_8.0.0.6.jar -DgroupId=com.ibm.mq.osgi -DartifactId=allclient -Dversion=9.0.0 -Dpackaging=jar

## Deploy IBMMQ onto OCP
1.Import image stream metadata

    oc import-image ibmmq --from=docker.io/ibmcom/mq --all --confirm
    
2.Deploy IBM MQ8

    oc new-app --image-stream=ibmmq:9 --env=LICENSE=accept --env=MQ_QMGR_NAME=QM1
    
3.Create service and route to allow external access

    oc create -f https://raw.githubusercontent.com/garethahealy/ibmq-to-amq-bridge/master/ocp-resources/ibmmq-nodeport-service.yaml
    oc create -f https://raw.githubusercontent.com/garethahealy/ibmq-to-amq-bridge/master/ocp-resources/ibmmq-webconsole-route.yaml
