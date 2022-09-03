#!/bin/bash
# shellcheck source=../src/builds/common.sh
. /builds/common.sh
# shellcheck source=../src/builds/env-vars.sh
. /builds/env-vars.sh
# shellcheck disable=SC1091
. /VERSIONS

build_setup

log_name="tcl_thread.log"
package_directory="tcl${TCL_VERSION}/pkgs/thread*"
if [ ! -d /workspaces/"${package_directory}" ]; then
    cd /workspaces && sh /builds/thread-download.sh
    tar xvfz "thread${THREAD_VERSION}".tar.gz
fi

mkdir -p /workspaces/logs
: > /workspaces/logs/"${log_name}"
echo "Running the autoconf configure in /workspaces/tcl/pkgs/thread*"
cd /workspaces/"${package_directory}" || exit 1
./configure --enable-threads --prefix="${PREFIX}" \
            --with-naviserver="${PREFIX}" 2>&1 | tee -a
/workspaces/logs/"${log_name}"
make 2>&1 | tee -a /workspaces/logs/"${log_name}"
make install

# cut down on the output to stdout to make Travis-CI consoles faster
make install 2>&1 | tee -a /workspaces/logs/"${log_name}" | cut -c1-64

build_cleanup
