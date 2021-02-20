#!/bin/bash
if [ ! -f nsf${xotcl_version}.tar.gz ] ; then
    echo wget ${wget_options} https://downloads.sourceforge.net/sourceforge/next-scripting/nsf${xotcl_version}.tar.gz
    wget ${wget_options} https://downloads.sourceforge.net/sourceforge/next-scripting/nsf${xotcl_version}.tar.gz
fi
