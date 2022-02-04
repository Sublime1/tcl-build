#!/bin/bash
# shellcheck source=../src/builds/common.sh
. /builds/common.sh
# shellcheck source=../src/builds/env-vars.sh
. /builds/env-vars.sh
# shellcheck disable=SC1091
. /VERSIONS

build_setup

package_directory="tcl${TCL_VERSION}"
if [ ! -d /workspaces/"${package_directory}" ]; then
    cd /workspaces && sh /builds/tcl-download.sh
    tar xfz "${package_directory}"-src.tar.gz
fi

if [ ! -f /workspaces/tcl/minizip ]; then
    # tcl8.7 assumes minizip in ../minizip, will cleanup when tcl8.7 releases
    cp /usr/bin/minizip /workspaces/"${package_directory}"/unix
fi

mkdir -p /workspaces/logs
: > /workspaces/logs/"${package_directory}".log
echo "Running the autoconf configure in /workspaces/tcl/unix"
cd /workspaces/"${package_directory}"/unix || exit 1
./configure --enable-threads --prefix="${PREFIX}" 2>&1 | tee -a
/workspaces/logs/"${package_directory}".log
make 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
make install

# Make sure, we have a tclsh in ns/bin
if [ -f "${PREFIX}"/bin/tclsh ] ; then
    rm "${PREFIX}"/bin/tclsh
fi

ln -sf "${PREFIX}"/bin/tclsh"${TCL_VERSION%.*}" "${PREFIX}"/bin/tclsh

build_cleanup
