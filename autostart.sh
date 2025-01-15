# PASSWORD=''
# echo $PASSWORD | sudo -S DEBIAN_FRONTEND=noninteractive apt-get -y update && sudo -S DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

#xhost local:root
#docker restart aistt
#docker exec aistt sh /aistt/AISmartToppingTable/run.sh

if ping -c 1 -W 5 google.com 1>/dev/null 2>&1
then
    # connected to the internet
    echo "$(date +%y-%m-%d_%T) System Power On" >> /home/gopizza/data/log/boot.log
    echo "$(date +%y-%m-%d_%T) Internet is connected" >> /home/gopizza/data/log/boot.log
else
    # not connected to the internet
    if [ -f "/home/gopizza/data/log/date.log" ]; then
        echo "$FILE exists."
        DATE="$(tail -n 1 $FILE)"
    else
        echo "$FILE Not exists." >> /home/gopizza/data/log/boot.log
        DATE="$(date +%y-%m-%d_%T)"
    fi
    timedatectl set-ntp false
    TEXTDATE="$(echo $DATE | cut -d "_" -f1) $(echo $DATE | cut -d "_" -f2)"
    echo "$TEXTDATE System Power On" >> /home/gopizza/data/log/boot.log
    echo "$TEXTDATE Internet is disconnected" >> /home/gopizza/data/log/boot.log
    CMDDATE="$(echo $DATE | cut -d "_" -f1)$(echo $DATE | cut -d "_" -f2)"
    CMD="timedatectl set-time $CMDDATE"
    $CMD
    timedatectl set-ntp true
fi


SHELL_NAME="aistt"
SESSION_OK=$(screen -ls |grep $SHELL_NAME)
echo Checking for $SESSION_OK
if [ "" = "$SESSION_OK" ]
then
        echo "NOT EXIST"
        echo "MAKE $SHELL_NAME SCREEN"
        xhost local:root
        docker restart aistt3
        /usr/bin/screen -S aistt -dm docker exec aistt3 sh /home/gopizza/aistt/run.sh
else

        echo "EXIST"
        echo "$SESSTION_OK"
fi

# docker restart guide

# docker logs --tail 20 -f aistt &
# google-chrome-stable http://192.168.0.62:3000/customer-screen --new-window -incognito -start-fullscreen --password-store=basic &
# google-chrome-stable http://192.168.0.62:3000/status --new-window -incognito -start-fullscreen --password-store=basic &

# google-chrome-stable http://192.168.0.62:18001/customer-screen --new-window -incognito -start-fullscreen --password-store=basic &
# google-chrome-stable http://192.168.0.62:18000/status --new-window -incognito -start-fullscreen --password-store=basic &