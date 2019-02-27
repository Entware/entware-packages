#!/bin/sh
GCONV_PATH=/opt/lib/gconv \
LANG=en_US.UTF-8 \
exec "/opt/libexec/softethervpn/${0##*/}" "$@"
