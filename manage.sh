#!/bin/sh
STORE_INDEX=$1
NAME=$2
IMAGE=$3
COUNTRY_CODE=$4

docker login
docker image pull $IMAGE

echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger

# 권한부여
# --privileged
CMD="docker run -it --name $NAME --gpus all -e STORE_INDEX=$STORE_INDEX -e COUNTRY_CODE=$COUNTRY_CODE --net host --ipc host -d"

# # set here the path to the directory containing your videos
# VIDEOPATH="/dev/video*" 

# for entry in $VIDEOPATH
# do
#     if [ -e $entry ] ; then
#         CMD+=" --device $entry:$entry"
#     else
#         echo "Not detected camera"
#     fi
# done

CMD+=" --device-cgroup-rule='c 189:* rmw' \
-e DISPLAY=unix$DISPLAY \
-v /dev/snd:/dev/snd \
-v /etc/localtime:/etc/localtime:ro \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /dev/bus/usb:/dev/bus/usb \
-v /var/run/dbus:/var/run/dbus \
futureplanning/aistt:aistt"

# docker rm -f $(docker ps -aq)

xhost local:root
eval $CMD

VAR1="$(cat $HOME/.profile | tail -1)"
VAR2="$(echo "gnome-terminal -- bash -c \"sh \\\"$HOME/project/autostart.sh\\\"; exec bash -i\"")"

if [ "$VAR1" = "$VAR2" ]; then
    echo 'Skip add to profile'
else
    echo "gnome-terminal -- bash -c \"sh \\\"$HOME/project/autostart.sh\\\"; exec bash -i\"" >> $HOME/.profile
fi