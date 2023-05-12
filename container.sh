#!/bin/sh

# 권한부여
# --privileged 

CMD="docker run -it --name aistt --gpus all --net host --ipc host"

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
aistt:1.0 /bin/bash"

echo "xhost local:root"
echo $CMD

echo "docker exec aistt sh /aistt/camera.sh"
echo "docker exec aistt sh /aistt/run.sh"