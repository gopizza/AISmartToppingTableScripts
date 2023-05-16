sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release

distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

sudo usermod -a -G docker $USER
docker login

docker image pull futureplanning/aistt:1.0
docker image pull redis

docker tag futureplanning/aistt:1.0 aistt:1.0

xhost local:root
nohup docker run -p 6379:6379 redis &

echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"' | sudo tee /etc/udev/rules.d/80-movidius.rules
sudo udevadm control --reload-rules && sudo udevadm trigger