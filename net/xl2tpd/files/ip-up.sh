#!/bin/sh

PATH=/opt/sbin:/opt/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

[ ! -z "$(which logger)" ] && logger "*** L2TP client connected [$*]"
iptables -I INPUT 1 -i $1 -j ACCEPT
iptables -I FORWARD 1 -i $1 -j ACCEPT
iptables -t nat -A POSTROUTING -o $1 -j MASQUERADE
