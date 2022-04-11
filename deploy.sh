#!/bin/bash

docker build -t coffeedeficient/multi-docker-client:latest -t coffeedeficient/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t coffeedeficient/multi-docker-server:latest -t coffeedeficient/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t coffeedeficient/multi-docker-worker:latest -t coffeedeficient/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push coffeedeficient/multi-docker-client:latest
docker push coffeedeficient/multi-docker-client:$SHA
docker push coffeedeficient/multi-docker-server:latest
docker push coffeedeficient/multi-docker-server:$SHA
docker push coffeedeficient/multi-docker-worker:latest
docker push coffeedeficient/multi-docker-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=coffeedeficient/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=coffeedeficient/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=coffeedeficient/multi-docker-worker:$SHA