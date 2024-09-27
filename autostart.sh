# PASSWORD=''
# echo $PASSWORD | sudo -S DEBIAN_FRONTEND=noninteractive apt-get -y update && sudo -S DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

#xhost local:root
#docker restart aistt
#docker exec aistt sh /aistt/AISmartToppingTable/run.sh


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