#!/bin/bash
# Read Date File
FILE="/home/gopizza/data/log/date.log"
if [ -f "$FILE" ]; then
    echo "$FILE exists."
    DATE="$(tail -n 1 $FILE)"
else
    echo "$FILE Not exists." >> /home/gopizza/data/log/boot.log
    DATE="$(date +%y-%m-%d_%T)"
fi
echo $DATE

# Check internet connection status
if ping -c 1 -W 5 google.com 1>/dev/null 2>&1
then
    # connected to the internet
    timedatectl set-ntp true
    CMD="/bin/timedatectl set-ntp true"
    $CMD
    echo "$(date +%y-%m-%d_%T) System Power On" >> /home/gopizza/data/log/boot.log
    echo "$(date +%y-%m-%d_%T) Internet is connected" >> /home/gopizza/data/log/boot.log
else
    # not connected to the internet
    timedatectl set-ntp false
    CMD="/bin/timedatectl set-ntp false"
    $CMD
    TEXTDATE="$(echo $DATE | cut -d "_" -f1) $(echo $DATE | cut -d "_" -f2)"
    echo "$TEXTDATE System Power On" >> /home/gopizza/data/log/boot.log
    echo "$TEXTDATE Internet is disconnected" >> /home/gopizza/data/log/boot.log
    CMDDATE="$(echo $DATE | cut -d "_" -f1)$(echo $DATE | cut -d "_" -f2)"
    CMD2="timedatectl set-time $CMDDATE"
    $CMD2
    timedatectl set-ntp true
fi
