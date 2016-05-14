#!/bin/sh

cd /opt/distributedlog

./bin/dlog com.twitter.distributedlog.service.DistributedLogServerApp \
           -p 8000 \
           --shard-id 1 \
           -sp 8001 \
           -u distributedlog://zookeeper:2181/messaging/my_namespace \
           -mx -c /opt/distributedlog/conf/distributedlog_proxy.conf
