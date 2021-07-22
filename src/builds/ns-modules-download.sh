#!/bin/bash
if [ ! -f naviserver-"${NS_MODULES_VERSION}"-modules.tar.gz ] ; then
    wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-"${NS_MODULES_VERSION}"-modules.tar.gz
fi
