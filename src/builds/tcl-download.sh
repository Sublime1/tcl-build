#!/bin/bash
if [ ! -f tcl"${TCL_VERSION}"-src.tar.gz ] ; then
    echo wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/tcl"${TCL_VERSION}"-src.tar.gz
    wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/tcl"${TCL_VERSION}"-src.tar.gz
fi
