#!/usr/bin/env bash

## check root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

## pre-installation
apt-get update -y && \
apt-get upgrade -y && \
apt-get install -y \
    wget curl htop tmux git zsh ncdu net-tools vim expect \
    unzip 7zip rsync \
    build-essential

## some awesome tools
# rclone
sudo -v ; curl https://rclone.org/install.sh | sudo bash

# CTOP
apt-get install ca-certificates curl gnupg lsb-release
curl -fsSL https://azlux.fr/repo.gpg.key | gpg --dearmor -o /usr/share/keyrings/azlux-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/azlux-archive-keyring.gpg] http://packages.azlux.fr/debian \
  $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azlux.list >/dev/null
apt-get update
apt-get install docker-ctop

# GDU
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz &&\
chmod +x gdu_linux_amd64 && \
mv gdu_linux_amd64 /usr/bin/gdu

# Oh-My-ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

## Install Docker
if [ -x "$(command -v docker)" ]; then
    echo "docker already installed"
else
    curl https://get.docker.com | sh && \
    systemctl --now enable docker
fi

# ## Install docker-compose (deprecated)
# if [ -x "$(command -v docker-compose)" ]; then
#     echo "docker-compose already installed"
# else
#     COMPOSE_LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/docker/compose/releases/latest) && \
#     COMPOSE_LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/') && \
#     sudo curl -L "https://github.com/docker/compose/releases/$(COMPOSE_LATEST_VERSION)/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
#     sudo chmod +x /usr/local/bin/docker-compose
# fi

## Disable Unattended update
expect << EOF
    spawn dpkg-reconfigure unattended-upgrades -freadline
    expect "Automatically download and install stable updates?"
    send "no\r"
    expect eof
EOF
