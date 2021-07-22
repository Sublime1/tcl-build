#!/bin/bash
if [ ! -f naviserver-"${NS_VERSION}".tar.gz ] ; then
    echo wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-"${NS_VERSION}".tar.gz
    wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-"${NS_VERSION}".tar.gz
fi
