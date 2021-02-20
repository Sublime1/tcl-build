#!/bin/bash
. /builds/common.sh
. /builds/ns-env-vars.sh

build_setup

if [ ! -d /workspaces/nsf${xotcl_version} ]; then
    cd /workspaces && sh /builds/ns-xotcl-download.sh
    tar xvfz nsf${xotcl_version}.tar.gz
fi

mkdir -p /workspaces/logs
cd /workspaces/nsf${xotcl_version} || exit 1
echo "Running the autoconf configure in nsf${xotcl_version}"
echo "Building nsf${xotcl_version}"
> /workspaces/logs/nsf${xotcl_version}.log
./configure --enable-threads --enable-symbols \
            --prefix=${ns_install_dir} --exec-prefix=${ns_install_dir} \
            --with-tcl=${ns_install_dir}/lib 2>&1 | tee -a /workspaces/logs/nsf${xotcl_version}.log
# cut down on the output to stdout to make Travis-CI consoles faster
make
make install 2>&1 | tee -a /workspaces/logs/nsf${xotcl_version}.log | cut -c1-64

build_cleanup
