#!/bin/sh
HOST=''
STORE_INDEX=$1

docker login
docker image pull futureplanning/aistt:aistt

docker tag futureplanning/aistt:aistt aistt:aistt

echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

# 권한부여
# --privileged 

CMD="docker run -it --name manage --gpus all -e STORE_INDEX=$STORE_INDEX -e HOST=$HOST --net host --ipc host -d"

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
-v /var/run/dbus:/var/run/dbus \
-v /var/run/NetworkManager:/var/run/NetworkManager \
aistt:manage /bin/bash"

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
