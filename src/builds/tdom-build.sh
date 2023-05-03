#!/bin/bash
  # shellcheck source=../src/builds/common.sh
  . /builds/common.sh
  # shellcheck source=../src/builds/env-vars.sh
  . /builds/env-vars.sh
  # shellcheck disable=SC1091
  . /VERSIONS

  build_setup

    package_directory=tdom-"${TDOM_VERSION}"

    if [ ! -d /workspaces/"${package_directory}" ]; then
        cd /workspaces && sh /builds/tdom-download.sh
        tar xvfz tdom-"${TDOM_VERSION}"-src.tgz
    fi

    mkdir -p /workspaces/logs
    echo "Running the autoconf configure in /workspaces/${package_directory}"
    cd /workspaces/"${package_directory}"/unix || exit 1
    echo "Building ${package_directory}"
    : > /workspaces/logs/"${package_directory}".log
    ../configure --enable-threads --disable-tdomalloc \
                --prefix="${PREFIX}" \
                --exec-prefix="${PREFIX}" \
                --with-tcl="${PREFIX}"/lib  2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    # cut down on the output to stdout to make Travis-CI consoles faster
    make
    make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log | cut -c1-64

    build_cleanup
