# Redis as Stateful Set With Sentinel

This is a proof of concept for running Redis with Sentinel on Kubernetes. In order to scale the size of the cluster, increase or decrease the replica count on the slave stateful set.

Kubernetes Version: **1.5.4**

Redis Version: **3.2**

## Building the Docker image
```shell
    docker build -t gcr.io/production-1309/redis:latest .
```

## Running the cluster

```shell
kubectl create -f master.json -f master-service.json -f slave.json -f slave-service.json -f sentinel.json -f sentinel-service.json
```