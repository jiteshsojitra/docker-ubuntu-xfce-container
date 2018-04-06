#!/bin/bash
set -euxo pipefail

# Create required directories
echo "Creating required directories..."
mkdir -p ~/.zcs-deps
mkdir -p ~/.ivy2/cache

# Environment variables
ENVIRONMENT_FILE="/etc/environment"
echo 'LANG=en_US.utf-8' >> $ENVIRONMENT_FILE
echo 'LANGUAGE='en_US:en'' >> $ENVIRONMENT_FILE
echo 'LC_ALL=en_US.utf-8' >> $ENVIRONMENT_FILE

# Update the repository sources list
echo "Updating the repository sources list..."
apt-get -qq autoremove -y
apt-get -qq update -y

# Install required packages
echo "Installing required packages..."
apt-get -qq install -y apt-utils \
	software-properties-common \
	build-essential \
	openssh-server \
	sudo \
	ant ant-optional ant-contrib \
	wget \
	iputils-ping \
	git \
	firefox \
	xdg-utils \
	libappindicator1 \
	fonts-liberation \
	libxss1 \
	vim \
	wget \
	net-tools \
	locales \
	bzip2 \
	python-numpy \
	libnss-wrapper \
	gettext

echo "Downloading ant contrib jar file..."
cd ~/.zcs-deps && wget https://files.zimbra.com/repository/ant-contrib/ant-contrib-1.0b1.jar

echo "Setting up ssh..."
# ssh-key setup and hack (when user changed for container)
#cat /dev/zero | ssh-keygen -C "jitesh.sojitra@synacor.com" -q -N "" > /dev/null
#mkdir -p $HOME/.ssh && ssh-keyscan github.com >> $HOME/.ssh/known_hosts

echo "Setting up timezone..."
echo "alias ll='ls -alF'" >> $HOME/.bashrc
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime