#!/bin/bash
if [ ! -f naviserver-${ns_version}.tar.gz ] ; then
    echo wget ${wget_options} https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-${ns_version}.tar.gz
    wget ${wget_options} https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-${ns_version}.tar.gz
fi
