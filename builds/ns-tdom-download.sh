#!/bin/bash
if [ ! -f tdom-${tdom_version}-src.tgz ] ; then
    echo wget ${wget_options} http://tdom.org/downloads/tdom-${tdom_version}-src.tgz
    wget ${wget_options} http://tdom.org/downloads/tdom-${tdom_version}-src.tgz
fi
