#!/usr/bin/env bash

NVIDIA_DRIVER_VERSION=525

## Install Graphic Driver
if [[ -n $NVIDIA_DRIVER_VERSION ]]; then
    apt-get install -y "nvidia-headless-${NVIDIA_DRIVER_VERSION}" "nvidia-utils-${NVIDIA_DRIVER_VERSION}"
fi

## NVIDIA Docker
if [ -x "$(command -v docker)" ]; then
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID) && \
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - && \
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list && \

    apt-get update -y
    apt-get install -y nvidia-docker2

    systemctl restart docker
fi
