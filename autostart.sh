docker restart node_redis
docker restart node_mongodb
docker restart node_nginx

docker restart manage
docker exec manage sh /aistt/run.sh

docker restart guide

# google-chrome-stable http://192.168.0.62:3000/customer-screen --new-window -incognito -start-fullscreen --password-store=basic
# google-chrome-stable http://192.168.0.62:3000/status --new-window -incognito -start-fullscreen --password-store=basic
