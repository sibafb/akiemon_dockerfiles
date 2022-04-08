#!/bin/bash

countainar_name="melodic-create"

# get parameter from system
user=`id -un`

# start sharing xhost
xhost +local:root

# run docker
# ref https://docs.docker.jp/engine/reference/index.html

# run command note
#--rm Clen Up https://docs.docker.jp/engine/reference/run.html#rm
#--net https://docs.docker.jp/engine/reference/run.html#network-settings
#--ipc https://docs.docker.jp/engine/reference/run.html#ipc-ipc
#--privileged https://docs.docker.jp/engine/reference/run.html#runtime-privilege-linux-capabilities 
#-v http://docs.docker.jp/v19.03/engine/reference/commandline/run.html#v-read-only
#-e http://docs.docker.jp/v19.03/engine/reference/commandline/run.html#e-env-env-file
#-it --name http://docs.docker.jp/v19.03/engine/reference/commandline/run.html#tty-name-it 
docker run --ipc=host \
  --device /dev/gpiomem \
  --device /dev/i2c-1 \
  --device /dev/ttyACM0 \
  --privileged \
  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
  -v $HOME/.Xauthority:$docker/.Xauthority \
  -v $HOME/work:$HOME/work \
  -e XAUTHORITY=$home_folder/.Xauthority \
  -e DISPLAY=$DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -p 11311:11311 \
  -p 9090:9090 \
  -p 8085:8085 \
  -it --name ${countainar_name} ${user}/${imege_name}
