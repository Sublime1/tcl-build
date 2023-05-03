#!/bin/bash
  # shellcheck source=../src/builds/common.sh
  . /builds/common.sh
  # shellcheck source=../src/builds/env-vars.sh
  . /builds/env-vars.sh
  # shellcheck disable=SC1091
  . /VERSIONS

  build_setup

  package_directory="thread${THREAD_VERSION}"
  if [ ! -d /workspaces/"${package_directory}" ]; then
      cd /workspaces && sh /builds/thread-download.sh
      tar xvfz "thread${THREAD_VERSION}".tar.gz
  fi

  mkdir -p /workspaces/logs
  echo "Running the autoconf configure in /workspaces/${package_directory}"
  cd /workspaces/"${package_directory}"/unix/ || exit1
  echo "Building thread"
  : > /workspaces/logs/"${package_directory}".log
  ../configure --enable-threads --prefix="${PREFIX}" --exec-prefix="${PREFIX}" --with-naviserver="${PREFIX}" --with-tcl="${PREFIX}"/lib 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
  # cut down on the output to stdout to make Travis-CI consoles faster
  make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log | cut -c1-64

  build_cleanup
