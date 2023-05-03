#!/bin/bash
  # shellcheck source=../src/builds/common.sh
  . /builds/common.sh
  # shellcheck source=../src/builds/env-vars.sh
  . /builds/env-vars.sh
  # shellcheck disable=SC1091
  . /VERSIONS

  build_setup

  package_directory="naviserver-${NS_VERSION}"
  if [ ! -d /workspaces/"${package_directory}" ]; then
      cd /workspaces && sh /builds/ns-download.sh
      tar zxvf naviserver-"${NS_VERSION}".tar.gz
  fi

  mkdir -p /workspaces/logs
  : > /workspaces/logs/"${package_directory}".log
  echo "Running the autoconf configure in /workspaces/${package_directory}"
  cd /workspaces/"${package_directory}" || exit 1
  ./configure --enable-threads --with-tcl="${PREFIX}"/lib --prefix="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
  # ./configure --with-tcl=${PREFIX}/lib --prefix=${PREFIX} 2>&1 | tee -a /workspaces/logs/${package_directory}.log

  echo "Building Naviserver"
  # cut down on the output to stdout to make Travis-CI consoles faster
  #make install 2>&1 | tee -a /workspaces/logs/${package_directory}.log | cut -c1-64
  export PATH="$PATH:${PREFIX}/bin"
  make build-doc  2>&1 | tee -a /workspaces/logs/"${package_directory}".log
  make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

  build_cleanup
