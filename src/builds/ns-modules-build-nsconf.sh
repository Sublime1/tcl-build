#!/bin/bash
  # shellcheck source=../src/builds/common.sh
  . /builds/common.sh
  # shellcheck source=../src/builds/env-vars.sh
  . /builds/env-vars.sh
  # shellcheck disable=SC1091
  . /VERSIONS

  build_setup

  package_directory="naviserver-${NS_MODULES_VERSION}-modules"
    if [ ! -d /workspaces/"${package_directory}" ]; then
        cd /workspaces && sh /builds/ns-modules-download.sh
        tar zxvf naviserver-"${NS_MODULES_VERSION}"-modules.tar.gz --transform s/modules/naviserver-"${NS_MODULES_VERSION}"-modules/
    fi

    mkdir -p /workspaces/logs
    : > /workspaces/logs/"${package_directory}".log
    echo "Running in /workspaces/${package_directory}/nsconf"
    cd /workspaces/"${package_directory}"/nsconf || exit 1
    make NAVISERVER="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    make NAVISERVER="${PREFIX}" install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

    build_cleanup
