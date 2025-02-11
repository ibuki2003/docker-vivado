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
  exec setpriv --reuid=vivado --regid=vivado --init-groups "$@"
else
  exec "$@"
fi
