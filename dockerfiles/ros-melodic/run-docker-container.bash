#!/bin/bash

countainar_name="ros-melodic-multi-turtle"

# get parameter from system
user=`id -un`

# start sharing xhost
xhost +local:user

# run docker
# ref https://docs.docker.jp/engine/reference/index.html

# run command note
#--rm Clen Up https://docs.docker.jp/engine/reference/run.html#rm
#--net https://docs.docker.jp/engine/reference/run.html#network-settings
#--net 
docker run --net=host\
  --ipc=host \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $HOME/.Xauthority:$docker/.Xauthority \
  -v $HOME/work:$HOME/work \
  -e XAUTHORITY=$home_folder/.Xauthority \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -it --name ${countainar_name} ${user}/ros-bionic-melodic
