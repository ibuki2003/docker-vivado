#!/usr/bin/env bash

cd $(dirname "$0")

IMAGE=${IMAGE:-vivado:v2024.1-asz}

CMD_DEFAULT='cd && . /opt/Xilinx/Vivado/2024.1/settings64.sh && _JAVA_AWT_WM_NONREPARENTING=1 LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1 vivado'
CMD="${@:-$CMD_DEFAULT}"

docker run \
  -it \
  --rm \
  -e "REUID=$(id -u)" \
  -e "REGID=$(id -g)" \
  -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v ./home:/home/vivado \
  -v ~/dev/vivado:/home/vivado/work \
  "$IMAGE" \
  /bin/bash -c "${CMD}"

