#!/bin/sh
HOST=''
STORE_INDEX='1'
TAG='aistt'
IMAGE='nvcr.io/nvidia/l4t-pytorch:r35.2.1-pth2.0-py3'

# 디렉토리 존재 유무 확인
if [ ! -d "/home/gopizza/Record" ]; then
    mkdir "/home/gopizza/Record"
fi

docker pull $IMAGE

echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

CMD="docker run -it --runtime nvidia --name $TAG -e STORE_INDEX=$STORE_INDEX -e HOST=$HOST --net host --privileged --ipc host -d -p 80:80"

CMD+=" --device-cgroup-rule='c 189:* rmw' \
-e DISPLAY=$DISPLAY \
-v /dev/snd:/dev/snd \
-v /etc/localtime:/etc/localtime:ro \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/bus/usb:/dev/bus/usb \
-v /var/run/dbus:/var/run/dbus \
-v /var/run/NetworkManager:/var/run/NetworkManager \
-v /home/gopizza/Record:/aistt/AISmartToppingTable/record_data \
$IMAGE"

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