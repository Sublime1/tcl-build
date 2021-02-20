#!/bin/bash
. /builds/common.sh
. /builds/ns-env-vars.sh

build_setup

package_directory="tcl${tcl_version}"
if [ ! -d /workspaces/${package_directory} ]; then
    cd /workspaces && sh /builds/ns-tcl-download.sh
    tar xfz ${package_directory}-src.tar.gz
fi

if [ ! -f /workspaces/tcl/minizip ]; then
    # tcl8.7 assumes minizip in ../minizip, will cleanup when tcl8.7 releases
    cp /usr/bin/minizip /workspaces/${package_directory}/unix
fi

mkdir -p /workspaces/logs
> /workspaces/logs/${package_directory}.log
echo "Running the autoconf configure in /workspaces/tcl/unix"
cd /workspaces/${package_directory}/unix || exit 1
./configure --enable-threads --prefix=${ns_install_dir} 2>&1 | tee -a /workspaces/logs/${package_directory}.log
make 2>&1 | tee -a /workspaces/logs/${package_directory}.log
make install

# Make sure, we have a tclsh in ns/bin
if [ -f ${ns_install_dir}/bin/tclsh ] ; then
    rm ${ns_install_dir}/bin/tclsh
fi

ln -sf ${ns_install_dir}/bin/tclsh${tcl_version%.*} ${ns_install_dir}/bin/tclsh

build_cleanup
