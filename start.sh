#!/bin/bash

docker service rm deployment-service
sleep 5
docker image rm deployment-service
sleep 5
docker build -t deployment-service .
sleep 5
docker service create --replicas 1 --network default_network --name deployment-service -e S_MONGO_HOST=mongo -e S_MONGO_DB=DeploymentService -e S_MONGO_USER=mongo -e S_MONGO_PASSWORD=mongo -e S_KAFKA_BOOTSTRAP_HOST=kafka:9092 -e S_SERVICE_APP_HOST=deployment-service -e S_LOGSTASH_HOST=logstash:4560 -p 8080:8080 deployment-service