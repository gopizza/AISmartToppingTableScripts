# AISTT Scripts
## install
+ git clone https://github.com/gopizza/AISmartToppingTableScripts.git
+ git checkout jetson_dev
+ vim container.sh
> STORE_INDEX='store_index'
>
> STORE INDEX 확인 : <https://api.gopizza.kr/bo/v1/stores>
>
> ctrl + F -> 매장 이름 검색 -> id = STORE_INDEX
>
> STORE_INDEX가 없을 시 업무 요청 ex) <https://www.wrike.com/workspace.htm?acc=5288081#/task-view?id=1519920194&pid=1437271030&cid=823474820>
> 
+ ./container.sh
+ docker login
+ + [error] permission denied while trying to connect to the Docker daemon socket
  > sudo usermod -aG docker $USER
  > 
  > sudo systemctl restart docker
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
