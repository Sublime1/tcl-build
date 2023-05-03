#!/bin/bash
  # shellcheck source=../src/builds/common.sh
  . /builds/common.sh
  # shellcheck source=../src/builds/env-vars.sh
  . /builds/env-vars.sh
  # shellcheck disable=SC1091
  . /VERSIONS

  build_setup

  package_directory="tcllib-${TCLLIB_VERSION}"
  if [ ! -d /workspaces/"${package_directory}" ]; then
      cd /workspaces && sh /builds/tcllib-download.sh
      tar xvfj tcllib-"${TCLLIB_VERSION}".tar.bz2
  fi

  mkdir -p /workspaces/logs
  echo "Running the autoconf configure in /workspaces/${package_directory}"
  cd /workspaces/"${package_directory}" || exit1
  echo "Building tcllib"
  : > /workspaces/logs/"${package_directory}".log
  ./configure --prefix="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
  # cut down on the output to stdout to make Travis-CI consoles faster
  make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log | cut -c1-64

  build_cleanup
