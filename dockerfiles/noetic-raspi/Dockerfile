# Image name : noetic-raspi

########## Pull ##########
FROM ros:noetic-perception

ENV ROS_DISTRO noetic

# Arguments
ARG USER=initial
ARG GROUP=initial
ARG UID=1000
ARG GID=${UID}
ARG SHELL=/bin/bash

# Replace apt urls
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl ssh \
    zsh terminator gnome-terminal git vim tig \
    dbus-x11 libglvnd0 libgl1 libglx0 libegl1 libxext6 libx11-6 \
    python3-osrf-pycommon python3-catkin-tools\
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN sudo apt-get update 
RUN sudo apt-get install -y iputils-ping net-tools

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

# Setup users and groups
RUN groupadd --gid ${GID} ${GROUP} \
  && useradd --gid ${GID} --uid ${UID} -ms ${SHELL} ${USER} \
  && mkdir -p /etc/sudoers.d \
  && echo "${USER}:x:${UID}:${UID}:${USER},,,:$HOME:${shell}" >> /etc/passwd \
  && echo "${USER}:x:${UID}:" >> /etc/group \
  && echo "${USER} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${USER}" \
  && chmod 0440 "/etc/sudoers.d/${USER}"

# copy entrypoint
COPY entrypoint.bash /entrypoint.bash
RUN chmod 777 /entrypoint.bash

# setup terminator config
RUN mkdir -p /home/${USER}/.config/terminator
COPY config/terminator/config /home/${USER}/.config/terminator
RUN sudo chown -R ${USER}:${GROUP} /home/${USER}/.config

# Switch user to ${USER}
USER ${USER}

# Make SSH available
EXPOSE 22

######### initial position ##########
WORKDIR /home/${USER}

RUN sudo apt-get update

RUN sudo apt-get install -y python3
RUN sudo apt install -y python-is-python3

RUN sudo apt install -y python3-pip

RUN sudo apt-get install -y python3-pigpio

# install rosserial
RUN sudo apt-get install -y ros-$ROS_DISTRO-rosserial-arduino
RUN sudo apt-get install -y ros-$ROS_DISTRO-rosserial

# install rosbridge
RUN sudo apt-get install -y ros-$ROS_DISTRO-rosbridge-suite
RUN sudo apt-get install -y ros-$ROS_DISTRO-roswww

RUN mkdir -p ~/catkin_ws/src

RUN sudo chown -R ${USER} ~/catkin_ws/

WORKDIR /home/${USER}/catkin_ws

RUN bash /opt/ros/$ROS_DISTRO/setup.bash

RUN catkin config --extend /opt/ros/$ROS_DISTRO

RUN bash /opt/ros/$ROS_DISTRO/setup.bash && catkin init

RUN bash /opt/ros/$ROS_DISTRO/setup.bash && catkin build

WORKDIR /home/${USER}/catkin_ws

RUN sudo apt install -y python3-vcstool

RUN sudo apt install -y python3-rosdep

RUN rosdep update

RUN rosdep install --from-paths src -yi

RUN cat << EOS >> ~/.bashrc

RUN export GAZEBO_IP=127.0.0.1

RUN export LASER=rplidar

RUN export NUM_ROBOTS=1

RUN export RVIZ=true

RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc

RUN echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

# CMD ["terminator"]
ENTRYPOINT ["/entrypoint.bash", "terminator"]
