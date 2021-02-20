#!/bin/bash
if [ ! -f naviserver-${ns_modules_version}-modules.tar.gz ] ; then
    wget ${wget_options} https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-${ns_modules_version}-modules.tar.gz
fi
