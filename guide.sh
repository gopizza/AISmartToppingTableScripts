#!/bin/bash

GUIDE_FRONT_BRANCH=$1
HOST=''

docker image pull nginx

docker image pull futureplanning/aistt:guide
docker tag futureplanning/aistt:guide aistt:guide

docker rm -f guide
docker rm -f node_nginx

docker run --name node_nginx -d nginx
docker run --name guide --gpus all -e GUIDE_FRONT_BRANCH=$GUIDE_FRONT_BRANCH -e HOST=$HOST -p 3000:3000 -p 5000:5000 --net host --ipc host -d aistt:guide