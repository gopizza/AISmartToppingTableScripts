# AISTT Scripts
## install
+ git clone https://github.com/gopizza/AISmartToppingTableScripts.git
+ git checkout jetson_dev
+ vim container.sh
> STORE_INDEX='store_index'
+ ./container.sh
+ docker login
+ docker start aistt3
+ docker attach aistt3
> cd /home/gopizza/aistt/AISmartToppingTableV3.0/pyLauncher
> 
> vim .env
> 
> ssh gopizza@raspberryPI
> 
> cp config_.json config.json
> 
> vim config.json
> 
> > GoEngine/Store/StoreIndex
> > 
> > GoEngine/Store/CameraIndex
> > 
> > GoEngine/Utils/Test = 0
> > 
> ctrl + p + q
> 

## Set Crontab
sudo crontab -e
> 10 1 * * * /sbin/shutdown -r now
> 
> @reboot sleep 60;/usr/bin/sh /home/gopizza/ydy/AISmartToppingTableScripts/autostart.sh
