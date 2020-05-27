#!/bin/sh

TOPDIR=/opt/share/seafile
INSTALLPATH=$TOPDIR/seafile-server

seafile start || exit 1

seahub python-env python3 "$INSTALLPATH/check_init_admin.py"

seafile stop
