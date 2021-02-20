#!/bin/bash
if [ ! -f tcllib-${tcllib_version}.tar.bz2 ] ; then
    wget ${wget_options} https://downloads.sourceforge.net/sourceforge/tcllib/tcllib-${tcllib_version}.tar.bz2
fi
