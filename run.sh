#!/usr/bin/env bash

cd $(dirname "$0")

IMAGE=${IMAGE:-vivado:v2024.1-asz}

CMD=('vivado')

if [ $# -gt 0 ]; then CMD=("$@"); fi

docker run \
  -it \
  --rm \
  -e "REUID=$(id -u)" \
  -e "REGID=$(id -g)" \
  -e "_JAVA_AWT_WM_NONREPARENTING=1" \
  -e "LD_PRELOAD=/lib/x86_64-linux-gnu/libudev.so.1" \
  -e DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v ./home:/home/vivado \
  -v ~/dev/vivado:/home/vivado/work \
  -w /home/vivado \
  "$IMAGE" \
  /bin/bash -c '. /opt/Xilinx/Vivado/2024.1/settings64.sh && "$@"' dummy "${CMD[@]}"

