# PASSWORD=''
# echo $PASSWORD | sudo -S DEBIAN_FRONTEND=noninteractive apt-get -y update && sudo -S DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

# xhost local:root

docker restart aistt
docker exec aistt sh /aistt/AISmartToppingTable/run.sh &

# echo "Waiting for the server to start..."
# until curl -s http://localhost:8080 > /dev/null; do
#     sleep 1
# done

# google-chrome-stable http://localhost:8080 --new-window -incognito -start-fullscreen --password-store=basic &



# docker restart guide
# docker logs --tail 20 -f aistt &
# google-chrome-stable http://192.168.0.62:3000/customer-screen --new-window -incognito -start-fullscreen --password-store=basic &
# google-chrome-stable http://192.168.0.62:3000/status --new-window -incognito -start-fullscreen --password-store=basic &

# google-chrome-stable http://192.168.0.62:18001/customer-screen --new-window -incognito -start-fullscreen --password-store=basic &
# google-chrome-stable http://192.168.0.62:18000/status --new-window -incognito -start-fullscreen --password-store=basic &