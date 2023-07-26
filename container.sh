#!/bin/sh
HOST='localhost'

docker login
docker image pull futureplanning/aistt:manage
docker image pull futureplanning/aistt:guide
docker image pull redis
docker image pull nginx

docker tag futureplanning/aistt:manage aistt:manage
docker tag futureplanning/aistt:guide aistt:guide

echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

# 권한부여
# --privileged 

CMD="docker run -it --name manage --gpus all -e HOST=$HOST --net host --ipc host"

# set here the path to the directory containing your videos
VIDEOPATH="/dev/video*" 

for entry in $VIDEOPATH
do
    if [ -e $entry ] ; then
        CMD+=" --device $entry:$entry"
    else
        echo "Not detected camera"
    fi
done

CMD+=" --device-cgroup-rule='c 189:* rmw' \
-e DISPLAY=unix$DISPLAY \
-v /dev/snd:/dev/snd \
-v /etc/localtime:/etc/localtime:ro \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/bus/usb:/dev/bus/usb \
aistt:manage /bin/bash"

echo "xhost local:root"
echo $CMD
echo "docker run --name node_redis -d -p 6379:6379 redis"
# echo "docker run --name node_mongodb -v ~/data:/data/db -d -p 27017:27017 mongo"
echo "docker run --name node_mongodb -d -p 27017:27017 mongo"
echo "docker run --name node_nginx -d nginx"
echo "docker run --name guide --gpus all -p 3000:3000 -p 5000:5000 -d aistt:guide"

echo "docker exec aistt sh /aistt/camera.sh"
echo "docker exec aistt sh /aistt/run.sh"

echo "gnome-terminal -- bash -c \"sh \\\"$HOME/project/autostart.sh\\\"; exec bash -i\""
