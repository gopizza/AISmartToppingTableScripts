PASSWORD=''

echo $PASSWORD | sudo -S DEBIAN_FRONTEND=noninteractive apt-get -y update && sudo -S DEBIAN_FRONTEND=noninteractive apt-get -y upgrade

xhost local:root
# docker restart node_redis
# docker restart node_mongodb
# docker restart node_nginx

docker restart aistt
# docker exec manage sh /aistt/run.sh

# docker restart guide

# docker logs --tail 20 -f aistt &
# google-chrome-stable http://192.168.0.62:3000/customer-screen --new-window -incognito -start-fullscreen --password-store=basic &
# google-chrome-stable http://192.168.0.62:3000/status --new-window -incognito -start-fullscreen --password-store=basic &

# google-chrome-stable http://192.168.0.62:18001/customer-screen --new-window -incognito -start-fullscreen --password-store=basic &
# google-chrome-stable http://192.168.0.62:18000/status --new-window -incognito -start-fullscreen --password-store=basic &