#!/bin/sh

set -e

if [ -n "$REUID" ] && [ -n "$REGID" ]; then
  userdel $REUID || true
  groupadd -f --gid "$REGID" vivado || true
  useradd --shell /bin/bash --uid "$REUID" --gid vivado --create-home vivado || true
  if tty="$(tty)"; then
    chown vivado "$tty"
  fi
  unset REUID REGID
  export HOME=~vivado
  if [ -n "$NO_RUNAS" ]; then
    exec "$@"
  else
    exec setpriv --reuid=vivado --regid=vivado --init-groups "$@"
  fi
else
  exec "$@"
fi
