#!/bin/bash
if [ ! -f tdom-"${TDOM_VERSION}"-src.tgz ] ; then
    echo wget "${WGET_OPTIONS}" http://tdom.org/downloads/tdom-"${TDOM_VERSION}"-src.tgz
    wget "${WGET_OPTIONS}" http://tdom.org/downloads/tdom-"${TDOM_VERSION}"-src.tgz
fi
