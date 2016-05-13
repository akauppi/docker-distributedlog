# Run a BookKeeper cluster on GCE with Kubernetes

This configuration files are to run a BookKeeper cluster with Kubernetes on GCE.

## Dependencies

- [Zookeeper](https://zookeeper.apache.org/)
- [Bookeeper](http://bookkeeper.apache.org/)
- [DistributedLog](github.com/twitter/distributedlog)

## Instructions

First you'll need to install the [Google Cloud SDK](https://cloud.google.com/sdk/gcloud/) and [kubernetes](http://kubernetes.io/).

### Configure GCloud

If you have to, first configure the project:

```sh
gcloud config set project <project-name>
gcloud config set compute/zone us-central1-c
```

### Create the kubernetes cluster

```sh
gcloud container clusters create bookkeeper --num-nodes 3
```

### Create the volumes

```sh
for disk in index journal ledger; do
    gcloud compute disks create --size 20GB bookkeeper-$disk
done

gcloud compute disks list
```

### Start zookeeper

```sh
kubectl create -f deploys/zookeeper.yaml
kubectl expose deployment/zookeeper-1
kubectl expose deployment/zookeeper-2
```

### Start bookkeeper


### Cleanup

```sh
kubectl delete -f deployment/bookkeeper.yaml
kubectl delete -f deploys/zookeeper.yaml
kubectl delete svc zookeeper-1
kubectl delete svc zookeeper-2
gcloud container clusters delete bookkeeper
```
