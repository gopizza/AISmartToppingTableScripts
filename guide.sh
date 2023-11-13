#!/bin/bash

GUIDE_FRONT_BRANCH=$1

if [ "442" == "$2" ]; then
  # 경성부경대
  STORE_CODE="00ba72b0"
elif [ "1" == "$2" ]; then
  # 대치
  STORE_CODE="10001"
elif [ "18" == "$2" ]; then
  # 평촌
  STORE_CODE="10011"
elif [ "412" == "$2" ]; then
  # 광화문
  STORE_CODE="d43d8059"
elif [ "354" == "$2" ]; then
  # 교대
  STORE_CODE="4ce6221e"
elif [ "427" == "$2" ]; then
  # 금정AK
  STORE_CODE="a08526d6"
elif [ "364" == "$2" ]; then
  # 교육장 + 1층 XGO
  STORE_CODE="f779f540"
else
  STORE_CODE=$2
fi

docker image pull nginx

docker image pull futureplanning/aistt:guide
docker tag futureplanning/aistt:guide aistt:guide

docker rm -f guide
docker rm -f node_nginx

docker run --name node_nginx -d nginx
docker run --name guide --gpus all -e GUIDE_FRONT_BRANCH=$GUIDE_FRONT_BRANCH -e STORE_CODE=$STORE_CODE -p 3000:3000 -p 5000:5000 --net host --ipc host -d aistt:guide
