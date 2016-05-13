#!/bin/bash

BK_CFG_FILE="/opt/bookkeeper/conf/bk_server.conf"

# Download the config file, if given a URL
if [ ! -z "$BK_CFG_URL" ]; then
  echo "[zk] Downloading zk config file from ${BK_CFG_URL}"
  curl --location --silent --insecure --output ${BK_CFG_FILE} ${BK_CFG_URL}
  if [ $? -ne 0 ]; then
    echo "[zk] Failed to download ${BK_CFG_URL} exiting."
    exit 1
  fi
fi

exec $@
