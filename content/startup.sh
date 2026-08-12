#!/bin/sh
set -eu

if [ ! -f /etc/frp/frpc.toml ]; then
  cp /lzcapp/pkg/content/frpc.toml /etc/frp/frpc.toml
fi

exec /usr/bin/frpc -c /etc/frp/frpc.toml
