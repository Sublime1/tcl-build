#!/bin/bash
. /builds/common.sh
. /builds/ns-env-vars.sh

build_setup

package_directory=nsf${xotcl_version}
if [ ! -d /workspaces/nsf${xotcl_version} ]; then
    cd /workspaces && sh /builds/ns-xotcl-download.sh
    tar xvfz nsf${xotcl_version}.tar.gz
fi

mkdir -p /workspaces/logs
cd /workspaces/${package_directory} || exit 1
echo "Running the autoconf configure in /workspaces/${package_directory}"
echo "Building nsf${xotcl_version}"
> /workspaces/logs/${package_directory}.log
./configure --enable-threads --enable-symbols \
            --prefix=${ns_install_dir} --exec-prefix=${ns_install_dir} \
            --with-tcl=${ns_install_dir}/lib 2>&1 | tee -a /workspaces/logs/${package_directory}.log
# cut down on the output to stdout to make Travis-CI consoles faster
make
make install 2>&1 | tee -a /workspaces/logs/${package_directory}.log

build_cleanup
