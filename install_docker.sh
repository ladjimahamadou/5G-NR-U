#!/bin/bash

# Installer les outils de base
sudo apt install -y git net-tools putty

# Mettre à jour les paquets et installer les dépendances nécessaires à Docker
sudo apt update
sudo apt install -y ca-certificates curl

# Ajouter la clé GPG officielle de Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Ajouter le dépôt Docker à APT sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour et installer Docker
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Ajouter l'utilisateur actuel au groupe docker
sudo usermod -a -G docker $(whoami)

# Redémarrer la machine pour appliquer les modifications de groupe
reboot

## Pulling the images from Docker Hub

docker pull oaisoftwarealliance/oai-amf:develop
docker pull oaisoftwarealliance/oai-nrf:develop
docker pull oaisoftwarealliance/oai-upf:develop
docker pull oaisoftwarealliance/oai-smf:develop
docker pull oaisoftwarealliance/oai-udr:develop
docker pull oaisoftwarealliance/oai-udm:develop
docker pull oaisoftwarealliance/oai-ausf:develop
docker pull oaisoftwarealliance/ims:latest
docker pull oaisoftwarealliance/oai-nssf:develop
docker pull oaisoftwarealliance/oai-pcf:develop
docker pull oaisoftwarealliance/oai-nef:develop
docker pull oaisoftwarealliance/oai-lmf:develop
# Utility image to generate traffic
docker pull oaisoftwarealliance/trf-gen-cn5g:latest

