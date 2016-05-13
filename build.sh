#!/bin/bash

: ${ZOOKEEPER_VERSION:="3.4.8"}
: ${BOOKKEEPER_VERSION:="4.3.2"}
: ${DISTRIBUTEDLOG_VERSION:="0.3.51"}

: ${DOCKER_BUILD_OPTS:="--rm=true "}

ZOOKEEPER_IMAGES="zookeeper"

for IMAGE in ${ZOOKEEPER_IMAGES}; do
  docker build $DOCKER_BUILD_OPTS -t "fcuny/${IMAGE}:${ZOOKEEPER_VERSION}" "${IMAGE}/"
  TAGS="${TAGS} fcuny/${IMAGE}:${ZOOKEEPER_VERSION}"
  docker tag $DOCKER_TAG_OPTS "fcuny/${IMAGE}:${ZOOKEEPER_VERSION}" "fcuny/${IMAGE}:latest"
  TAGS="${TAGS} fcuny/${IMAGE}:latest"
done

BOOKKEEPER_IMAGES="bookkeeper"

for IMAGE in ${BOOKKEEPER_IMAGES}; do
  docker build ${DOCKER_BUILD_OPTS} -t "fcuny/${IMAGE}:${BOOKKEEPER_VERSION}" "${IMAGE}/"
  TAGS="${TAGS} fcuny/${IMAGE}:${BOOKKEEPER_VERSION}"
  docker tag $DOCKER_TAG_OPTS "fcuny/${IMAGE}:${BOOKKEEPER_VERSION}" "fcuny/${IMAGE}:latest"
  TAGS="${TAGS} fcuny/${IMAGE}:latest"
done

DISTRIBUTEDLOG_IMAGES="distributedlog"

for IMAGE in ${DISTRIBUTEDLOG_IMAGES}; do
  docker build ${DOCKER_BUILD_OPTS} -t "fcuny/${IMAGE}:${DISTRIBUTEDLOG_VERSION}" "${IMAGE}/"
  TAGS="${TAGS} fcuny/${IMAGE}:${DISTRIBUTEDLOG_VERSION}"
  docker tag $DOCKER_TAG_OPTS "fcuny/${IMAGE}:${DISTRIBUTEDLOG_VERSION}" "fcuny/${IMAGE}:latest"
  TAGS="${TAGS} fcuny/${IMAGE}:latest"
done
