sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# sudo apt -y install nvidia-driver-510
sudo apt -y install nvidia-driver-470

distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

sudo usermod -a -G docker $USER

sudo apt -y update
sudo apt -y upgrade

sudo apt -y install ffmpeg net-tools vim openssh-server
sudo ufw allow 22

cp autostart.sh ..
sudo reboot
