############################################################
# Inspired by "Tobias Schneck" for Dockerfile creation from https://hub.docker.com/r/consol/ubuntu-xfce-vnc.
#
# Dockerfile: https://hub.docker.com/r/jiteshsojitra/docker-ubuntu-xfce-container
# This docker file is used to build an vnc image based on Ubuntu OS & Xfce UI.
# Connection ports for controlling the UI:
# VNC port: 5901, connect with <host-ip> and 5901 port
# noVNC port: 6901, connect via http://<host-ip>:6901/?password=<vnc-password>
############################################################

FROM ubuntu:16.04
MAINTAINER "Jitesh Sojitra <jiteshsojitra@gmail.com>"

# Environment variables
ENV REFRESHED_AT=2018-04-01
ENV HOME=/root \
	SCRIPTS_DIR=/root/scripts \
	NO_VNC_DIR=/root/noVNC \
	DISPLAY=:1 \
	TERM=xterm \
	VNC_PORT=5901 \
	NO_VNC_PORT=6901 \
	VNC_COL_DEPTH=24 \
	VNC_RESOLUTION=1360x768 \
	VNC_PW=test123 \
	VNC_VIEW_ONLY=false \
	DEBIAN_FRONTEND=noninteractive \
	LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# Working directory
WORKDIR $HOME

# Expose ports
EXPOSE $VNC_PORT $NO_VNC_PORT

# Add scripts
ADD ./src/scripts $SCRIPTS_DIR
RUN find $SCRIPTS_DIR -name '*.sh' -exec chmod a+x {} +

# Install OS packages
RUN $SCRIPTS_DIR/packages.sh

# Install required softwares
RUN $SCRIPTS_DIR/core.sh
ADD ./src/xfce $HOME

# Install required utilities
RUN $SCRIPTS_DIR/utils.sh

# Post configurations
RUN $SCRIPTS_DIR/post-configs.sh

# Set permissions
RUN $SCRIPTS_DIR/set-permissions.sh $SCRIPTS_DIR $HOME

# Entrypoint
ENTRYPOINT ["/root/scripts/vnc-startup.sh"]
CMD ["--tail-log"]