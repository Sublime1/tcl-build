#!/bin/bash
if [ ! -f tcl"${TCL_VERSION}"-src.tar.gz ] ; then
    echo wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/tcl"${TCL_VERSION}"-src.tar.gz 2>&1
    wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/tcl"${TCL_VERSION}"-src.tar.gz 2>&1
else
    echo "File tcl${TCL_VERSION}-src.tar.gz exist. Skip download." 2>&1
fi
