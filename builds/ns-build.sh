#!/bin/bash
. /builds/common.sh
. /builds/ns-env-vars.sh

build_setup

package_directory="naviserver-${ns_version}"
if [ ! -d /workspaces/${package_directory} ]; then
    cd /workspaces && sh /builds/ns-download.sh
    tar zxvf naviserver-${ns_version}.tar.gz
fi

mkdir -p /workspaces/logs
> /workspaces/logs/${package_directory}.log
echo "Running the autoconf configure in /workspaces/${package_directory}"
cd /workspaces/${package_directory} || exit 1
./configure --with-tcl=${ns_install_dir}/lib --prefix=${ns_install_dir} 2>&1 | tee -a /workspaces/logs/${package_directory}.log

echo "Building Naviserver"
# cut down on the output to stdout to make Travis-CI consoles faster
#make install 2>&1 | tee -a /workspaces/logs/${package_directory}.log | cut -c1-64
export PATH=$PATH:${ns_install_dir}/bin
make build-doc  2>&1 | tee -a /workspaces/logs/${package_directory}.log
make install 2>&1 | tee -a /workspaces/logs/${package_directory}.log

build_cleanup
