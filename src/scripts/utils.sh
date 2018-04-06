#!/bin/bash
set -euxo pipefail

# Sublime editor
echo "Installing sublime editor..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - && \
apt-get -qq install -y apt-transport-https && \
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list && \
apt-get -qq update -y && \
apt-get -qq install -y sublime-text

# Clean up
echo "Cleaning up..."
apt-get -qq clean -y