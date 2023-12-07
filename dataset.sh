#!/bin/bash
PWD=$(pwd)
echo "Now Directory : $PWD"

STORE_CODE=${2:-"f779f540"}
COUNTRY=${3:-"kr"}
DOTENV=${4:-"mushroom"}
SAVE_TYPE=${5:-"scp"}
SAVE_PATH=${6:-"hdisk/collected"}

if [ "build" == $1 ]; then
    docker build -t futureplanning/aistt:collect_data .
elif [ "run" == $1 ]; then
    docker stop collect_data && docker rm collect_data
    docker pull futureplanning/aistt:collect_data
    docker tag futureplanning/aistt:collect_data aistt:collect_data
    docker run -it -e "STORE_CODE=$STORE_CODE" -e "COUNTRY=$COUNTRY" -e "DOTENV=$DOTENV" -e "SAVE_TYPE=$SAVE_TYPE" -e "SAVE_PATH=$SAVE_PATH" --net host --ipc host --name collect_data -d futureplanning/aistt:collect_data
elif [ "exec" == $1 ]; then
    docker exec -it collect_data bash
elif [ "redis" == $1 ]; then
    if [ "pull" == $2 ]; then
        docker pull redis:latest
    elif [ "run" == $2 ]; then
        docker run --name node_redis -d -p 6379:6379 redis
    if
else
    echo "Wrong argument or nothing!"
fi
