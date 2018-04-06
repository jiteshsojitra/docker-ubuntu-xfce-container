#!/bin/bash
set -euxo pipefail

# Xfce UI
echo "Installing Xfce4 UI components"
apt-get -qq install -y supervisor xfce4 xfce4-terminal
apt-get -qq purge -y pm-utils xscreensaver*

# Java
echo "Installing Java..."
echo "===> Add webupd8 repository..."  && \
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
apt-get -qq update -y && \
echo "===> Install Java8"  && \
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
DEBIAN_FRONTEND=noninteractive apt-get -qq install -y oracle-java8-installer oracle-java8-set-default && \
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Chrome browser
echo "Installing chrome browser..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
dpkg -i google-chrome-stable_current_amd64.deb; apt-get -y install && \
rm google-chrome-stable_current_amd64.deb
#sed -i -e 's@Exec=/usr/bin/google-chrome-stable %U@Exec=/usr/bin/google-chrome-stable %U --no-sandbox@g' /usr/share/applications/google-chrome.desktop && \
#ln -s /usr/share/applications/google-chrome.desktop ~/Desktop && \
#chmod +x ~/Desktop/google-chrome.desktop

# TigerVNC
echo "Installing TigerVNC server..."
wget -qO- https://dl.bintray.com/tigervnc/stable/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C /

# noVNC
echo "Installing noVNC..."
mkdir -p $NO_VNC_DIR/utils/websockify
wget -qO- https://github.com/novnc/noVNC/archive/v0.6.2.tar.gz | tar xz --strip 1 -C $NO_VNC_DIR
# Use older version of websockify to prevent hanging connections on offline containers, see https://github.com/ConSol/docker-headless-vnc-container/issues/50
wget -qO- https://github.com/novnc/websockify/archive/v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_DIR/utils/websockify
chmod +x -v $NO_VNC_DIR/utils/*.sh
# Create index.html to forward automatically to `vnc_auto.html`
ln -s $NO_VNC_DIR/vnc_auto.html $NO_VNC_DIR/index.html