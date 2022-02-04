#!/bin/bash
# shellcheck source=../src/builds/common.sh
. /builds/common.sh
# shellcheck source=../src/builds/env-vars.sh
. /builds/env-vars.sh
# shellcheck disable=SC1091
. /VERSIONS

build_setup

package_directory="nsf${XOTCL_VERSION}"
if [ ! -d /workspaces/"nsf${XOTCL_VERSION}" ]; then
    cd /workspaces && sh /builds/xotcl-download.sh
    tar xvfz "nsf${XOTCL_VERSION}".tar.gz
fi

mkdir -p /workspaces/logs
cd /workspaces/"${package_directory}" || exit 1
echo "Running the autoconf configure in /workspaces/${package_directory}"
echo "Building nsf${XOTCL_VERSION}"
: > /workspaces/logs/"${package_directory}".log
./configure --enable-threads --enable-symbols \
            --prefix="${PREFIX}" --exec-prefix="${PREFIX}" \
            --with-tcl="${PREFIX}"/lib 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
# cut down on the output to stdout to make Travis-CI consoles faster
make
make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

build_cleanup
