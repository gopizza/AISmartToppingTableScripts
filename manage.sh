#!/bin/sh
HOST=''
STORE_INDEX=$1
TAG=$2

docker login
docker image pull futureplanning/aistt:$TAG

docker tag futureplanning/aistt:$TAG aistt:$TAG

echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

# 권한부여
# --privileged
ENV_PATH='/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/cuda-11.8/bin'
LIB_PATH='/usr/local/nvidia/lib:/usr/local/nvidia/lib64:/usr/local/cuda-11.8/lib64:/aistt/TensorRT-8.5.2.2/lib'

CMD="docker run -it --name $TAG --gpus all -e STORE_INDEX=$STORE_INDEX -e HOST=$HOST -e PATH=$ENV_PATH -e LD_LIBRARY_PATH=$LIB_PATH --net host --ipc host -d"

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

# -v /home/gopizza/Record:/aistt/AISmartToppingTable/Record/data

CMD+=" --device-cgroup-rule='c 189:* rmw' \
-e DISPLAY=unix$DISPLAY \
-v /dev/snd:/dev/snd \
-v /etc/localtime:/etc/localtime:ro \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/bus/usb:/dev/bus/usb \
-v /var/run/dbus:/var/run/dbus \
-v /var/run/NetworkManager:/var/run/NetworkManager \
aistt:$TAG"

# echo "xhost local:root"
# echo $CMD
# echo "docker run --name node_redis -d -p 6379:6379 redis"
# # echo "docker run --name node_mongodb -v ~/data:/data/db -d -p 27017:27017 mongo"
# echo "docker run --name node_mongodb -d -p 27017:27017 mongo"
# echo "docker run --name node_nginx -d nginx"
# echo "docker run --name guide --gpus all -e GUIDE_FRONT_BRANCH=$GUIDE_FRONT_BRANCH -p 3000:3000 -p 5000:5000 -d aistt:guide"

# echo "docker exec aistt sh /aistt/camera.sh"
# echo "docker exec aistt sh /aistt/run.sh"

# echo "gnome-terminal -- bash -c \"sh \\\"$HOME/project/autostart.sh\\\"; exec bash -i\""

# docker rm -f manage
# docker rm -f node_redis
# docker rm -f node_mongodb

docker rm -f $(docker ps -aq)

xhost local:root
eval $CMD
# docker run --name node_redis -d -p 6379:6379 redis
# docker run --name node_mongodb -d -p 27017:27017 mongo

VAR1="$(cat $HOME/.profile | tail -1)"
VAR2="$(echo "gnome-terminal -- bash -c \"sh \\\"$HOME/project/autostart.sh\\\"; exec bash -i\"")"

if [ "$VAR1" = "$VAR2" ]; then
    echo 'Skip add to profile'
else
    echo "gnome-terminal -- bash -c \"sh \\\"$HOME/project/autostart.sh\\\"; exec bash -i\"" >> $HOME/.profile
fi
