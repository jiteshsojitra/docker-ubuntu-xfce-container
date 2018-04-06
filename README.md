# Docker image with Ubuntu OS, Xfce desktop & VNC container

Docker image is installed with the following components:
* Xfce4 desktop environment
* VNC-Server (default VNC port: 5901)
* noVNC - HTML5 VNC client (https://github.com/kanaka/noVNC) (default http port: 6901)
* Git

# Usage:
Run command with mapping to local port 5901 (vnc protocol) and 6901 (vnc web access):
- docker run -d -p 5901:5901 -p 6901:6901 jiteshsojitra/docker-ubuntu-xfce-container

If you want to get into the container use interactive mode:
- docker run -it -p 5901:5901 -p 6901:6901 --entrypoint /bin/bash jiteshsojitra/docker-ubuntu-xfce-container

If you want to override the VNC resolution:
- docker run -d -p 5901:5901 -p 6901:6901 -e VNC_RESOLUTION=1360x768 jiteshsojitra/docker-ubuntu-xfce-container

If you want to change the VNC password:
- docker run -d -p 5901:5901 -p 6901:6901 -e VNC_PW=<vnc-password> jiteshsojitra/docker-ubuntu-xfce-container

Build an image from scratch:
- docker build -t jiteshsojitra/docker-ubuntu-xfce-container

# Connection ports for controlling the UI:
- VNC port:5901, connect with <host-ip> and 5901 port
- noVNC port: 6901, connect via http://<host-ip>:6901/?password=<vnc-password>

# Credits:
- Tobias Schneck (https://hub.docker.com/r/consol/ubuntu-xfce-vnc)

# Contact:
- Jitesh Sojitra (jiteshsojitra@gmail.com)