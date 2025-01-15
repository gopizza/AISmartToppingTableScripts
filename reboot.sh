#! /bin/bash
# 인터넷 연결 상태 확인
rm /home/gopizza/data/log/date.log
echo "$(date +%y-%m-%d_%T -d 5minute)" >> /home/gopizza/data/log/date.log
if ping -c 1 -W 5 google.com 1>/dev/null 2>&1
then
    echo "$(date +%y-%m-%d_%T) Internet is connected" >> /home/gopizza/data/log/boot.log
    echo "$(date +%y-%m-%d_%T) System Power Off" >> /home/gopizza/data/log/boot.log
    sudo shutdown -r
else
    echo "$(date +%y-%m-%d_%T) Internet is disconnected" >> /home/gopizza/data/log/boot.log
    echo "Start Program"
    /usr/bin/sh /home/gopizza/aistt/AISmartToppingTableV3.0/autostart.sh
fi