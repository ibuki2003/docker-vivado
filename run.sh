#!env bash
docker run \
  -it \
  --rm \
  -e "REUID=$(id -u)" \
  -e "REGID=$(id -g)" \
  -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v ~/dev/vivado:/work \
  -v ./home:/home/vivado \
  vivado:v2024.1 \
  /bin/bash -c 'cd && . /opt/Xilinx/Vivado/2024.1/settings64.sh && _JAVA_AWT_WM_NONREPARENTING=1 LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 vivado'

