#!/bin/bash
. /builds/common.sh
. /builds/ns-env-vars.sh

build_setup

package_directory="tcllib-${tcllib_version}"
if [ ! -d /workspaces/${package_directory} ]; then
    cd /workspaces && sh /builds/ns-tcllib-download.sh
    tar xvfj tcllib-${tcllib_version}.tar.bz2
fi

mkdir -p /workspaces/logs
echo "Running the autoconf configure in /workspaces/${package_directory}"
cd /workspaces/${package_directory} || exit1
echo "Building tcllib"
> /workspaces/logs/${package_directory}.log
./configure --prefix=${ns_install_dir} 2>&1 | tee -a /workspaces/logs/${package_directory}.log
# cut down on the output to stdout to make Travis-CI consoles faster
make install 2>&1 | tee -a /workspaces/logs/${package_directory}.log | cut -c1-64

build_cleanup
