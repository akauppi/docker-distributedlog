# docker-distributedlog

## Quick Start

By following this quick start, you'll get a working setup similar to the [tutorial for DistributedLog](http://distributedlog.io/html/basics/quickstart.html).

### Zookeeper

You need zookeeper up and running. We will start with only one node for our scenario.

```sh
docker run -d --name zookeeper -p 2181:2181 fcuny/zookeeper
```

### Bookkeeper

A working bookkeeper cluster is also required. For now we start with only one node.

The first step is to create the metadata in zookeeper (paths and so on):

```sh
docker run --rm --link zookeeper:zookeeper -e BOOKKEEPER_ZOOKEEPER_CONNECT=zookeeper:2181 fcuny/bookkeeper -- /opt/bookkeeper/bin/bookkeeper shell metaformat -nonInteractive
```

Once this is done, we can start a bookie:

```sh
docker run -d --name bookkeeper -p 3181:3181 --link zookeeper:zookeeper -e BOOKKEEPER_ZOOKEEPER_CONNECT=zookeeper:2181 fcuny/bookkeeper
```

### DistributedLog

To get DistributedLog running, we need to create the binding and a few streams:

```sh
docker run --rm --name distributedlog -p 7000:7000 --link zookeeper:zookeeper fcuny/distributedlog /opt/distributedlog/bin/dlog admin bind -l /ledgers -s zookeeper:2181 -c distributedlog://zookeeper:2181/messaging/my_namespace
docker run --rm --name distributedlog -p 7000:7000 --link zookeeper:zookeeper fcuny/distributedlog /opt/distributedlog/bin/dlog tool create -f -u distributedlog://zookeeper:2181/messaging/my_namespace -r messaging-stream- -e 1-5
```

We can verify that the streams were created with

```sh
docker run --rm --name distributedlog -p 7000:7000 --link zookeeper:zookeeper fcuny/distributedlog /opt/distributedlog/bin/dlog tool list -u distributedlog://zookeeper:2181/messaging/my_namespace
```

At this point, we can start a write proxy:

```sh
docker run -d --name write-proxy -p 8000:8000 --link zookeeper:zookeeper --link bookkeeper:bookkeeper fcuny/distributedlog
```

## Building images

Run the `build.sh` script to build the images for zookeeper, bookkeeper and distributedlog.

## Examples

The directory **examples/k8s** contains scripts and configuration to deploy the whole setup on [Kubernetes](http://kubernetes.io/) in [Google Cloud](https://cloud.google.com/).
