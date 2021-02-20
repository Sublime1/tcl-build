#!/bin/bash
if [ ! -f tcl${tcl_version}-src.tar.gz ] ; then
    echo wget ${wget_options} https://downloads.sourceforge.net/sourceforge/tcl/tcl${tcl_version}-src.tar.gz
    wget ${wget_options} https://downloads.sourceforge.net/sourceforge/tcl/tcl${tcl_version}-src.tar.gz
fi
