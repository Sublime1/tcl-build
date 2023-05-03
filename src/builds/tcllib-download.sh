#!/bin/bash
if [ ! -f tcllib-"${TCLLIB_VERSION}".tar.bz2 ] ; then
    wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcllib/tcllib-"${TCLLIB_VERSION}".tar.bz2
else
    echo "tcllib-${TCLLIB_VERSION}.tar.bz2 exist. Skip download." 2>&1
fi
