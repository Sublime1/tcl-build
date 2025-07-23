#!/bin/bash
if [ ! -f tcllib-"${TCLLIB_VERSION}".tar.gz ] ; then
    wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcllib/tcllib-"${TCLLIB_VERSION}".tar.gz
else
    echo "tcllib-${TCLLIB_VERSION}.tar.gz exist. Skip download." 2>&1
fi
