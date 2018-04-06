### Docker image with Ubuntu OS, Xfce desktop & VNC container

### Docker hub image/container:
https://hub.docker.com/r/jiteshsojitra/docker-ubuntu-xfce-container/

Docker image is installed with the following components:
* UBUNTU server
* Xfce desktop
* VNC server (default VNC port: 5901)
* VNC client with html5 support (default http port: 6901)
* OpenSSH
* Java
* Git
* Ant
* Vim
* Mozilla Firefox
* Google Chrome
* Sublime Editor

### Usage:
Run command with mapping to local port 5901 (vnc protocol) and 6901 (vnc web access):
- docker run -d -p 5901:5901 -p 6901:6901 jiteshsojitra/docker-ubuntu-xfce-container

If you want to get into the container use interactive mode:
- docker run -it -p 5901:5901 -p 6901:6901 --entrypoint /bin/bash jiteshsojitra/docker-ubuntu-xfce-container

If you want to override the VNC resolution:
- docker run -d -p 5901:5901 -p 6901:6901 -e VNC_RESOLUTION=1360x768 jiteshsojitra/docker-ubuntu-xfce-container

If you want to change the VNC password:
- docker run -d -p 5901:5901 -p 6901:6901 -e VNC_PW=[vnc-password] jiteshsojitra/docker-ubuntu-xfce-container

Build an image from scratch:
- docker build -t jiteshsojitra/docker-ubuntu-xfce-container

### Connection ports for controlling the UI:
- VNC port: 5901, connect with [host-ip] and 5901 port
- noVNC port: 6901, connect via http://[host-ip]:6901/?password=[vnc-password]

### Note:
- There are some settings in docker container which are required for building Zimbra Selenium (https://github.com/Zimbra/zm-selenium).

### Credits:
- Tobias Schneck (https://hub.docker.com/r/consol/ubuntu-xfce-vnc)

### Contact:
- Jitesh Sojitra (jiteshsojitra@gmail.com)