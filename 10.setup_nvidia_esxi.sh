#!/usr/bin/env bash


## Select in https://www.nvidia.com/en-us/drivers/unix/
DRIVER_VERSION=525.105.17

## Disable Nouveau
echo -e "blacklist nouveau\noptions nouveau modset=0" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf >/dev/null

## Nvidia Driver
BASE_URL=https://us.download.nvidia.com/tesla
curl -fSsl -O $BASE_URL/$DRIVER_VERSION/NVIDIA-Linux-x86_64-$DRIVER_VERSION.run
sh NVIDIA-Linux-x86_64-$DRIVER_VERSION.run -m=kernel-open

echo "options nvidia NVreg_OpenRmEnableUnsupportedGpus=1" | sudo tee /etc/modprobe.d/nvidia.conf >/dev/null


## NVIDIA Docker
if [ -x "$(command -v docker)" ]; then
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && \
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - && \
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list && \

    apt-get update -y
    apt-get install -y nvidia-docker2

    systemctl restart docker
fi