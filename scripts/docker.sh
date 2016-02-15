#!/usr/bin/env bash

echo ">>> Installing Docker"

# Add Key
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# Add Repository
sudo sh -c "echo https://apt.dockerproject.org/repo ubuntu-vivid main > /etc/apt/sources.list.d/docker.list"
sudo apt-get update

# Install Docker
sudo apt-get install -y linux-image-extra-$(uname -r)
sudo apt-get install -y docker-engine
sudo systemctl enable docker

# Make the vagrant user able to interact with docker without sudo
if [ ! -z "$1" ]; then
	if [ "$1" == "permissions" ]; then
		echo ">>> Adding vagrant user to docker group"

		sudo usermod -a -G docker vagrant

	fi # permissions
fi # arg check
