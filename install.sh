sudo apt -y update
sudo apt -y upgrade

sudo usermod -a -G docker $USER

sudo apt -y install ffmpeg net-tools vim openssh-server
sudo ufw allow 22

cp autostart.sh ..
sudo reboot