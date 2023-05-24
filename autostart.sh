docker restart aistt
docker restart node_redis
docker exec aistt sh /aistt/run.sh
# google-chrome-stable http://192.168.0.62:3000/customer-screen -kiosk --password-store=basic