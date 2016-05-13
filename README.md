# docker-distributedlog

## Building images

Run the `build.sh` script to build the images for zookeeper, bookkeeper and distributedlog.

## Run it

```sh
docker run -t fcuny/zookeeper ...
docker run -t fcuny/bookkeeper ...
docker run -t fcuny/distributedlog ...
```

## Examples

The directory **examples/k8s** contains scripts and configuration to deploy the whole setup on [Kubernetes](http://kubernetes.io/) in [Google Cloud](https://cloud.google.com/).

