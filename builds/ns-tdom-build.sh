#!/bin/bash
. /builds/common.sh
. /builds/ns-env-vars.sh

build_setup

package_directory=tdom-${tdom_version}

if [ ! -d /workspaces/${package_directory} ]; then
    cd /workspaces && sh /builds/ns-tdom-download.sh
    tar xvfz tdom-${tdom_version}-src.tgz
fi

mkdir -p /workspaces/logs
echo "Running the autoconf configure in /workspaces/${package_directory}"
cd /workspaces/${package_directory}/unix || exit 1
echo "Building ${package_directory}"
> /workspaces/logs/${package_directory}.log
../configure --enable-threads --disable-tdomalloc \
            --prefix=${ns_install_dir} \
            --exec-prefix=${ns_install_dir} \
            --with-tcl=${ns_install_dir}/lib  2>&1 | tee -a /workspaces/logs/${package_directory}.log
# cut down on the output to stdout to make Travis-CI consoles faster
make
make install 2>&1 | tee -a /workspaces/logs/${package_directory}.log | cut -c1-64

build_cleanup
