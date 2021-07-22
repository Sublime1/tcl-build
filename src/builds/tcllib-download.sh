#!/bin/bash
if [ ! -f tcllib-"${TCLLIB_VERSION}".tar.bz2 ] ; then
    wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcllib/tcllib-"${TCLLIB_VERSION}".tar.bz2
fi
