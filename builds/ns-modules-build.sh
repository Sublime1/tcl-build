#!/bin/bash
. /builds/common.sh
  . /builds/ns-env-vars.sh

  build_setup

package_directory="naviserver-${ns_modules_version}-modules"
  if [ ! -d /workspaces/${package_directory} ]; then
      cd /workspaces && sh /builds/ns-modules-download.sh
      tar zxvf naviserver-${ns_modules_version}-modules.tar.gz --transform s/modules/naviserver-${ns_modules_version}-modules/
  fi

  mkdir -p /workspaces/logs
  > /workspaces/logs/${package_directory}.log
  echo "Running in /workspaces/${package_directory}/nsdbpg"
  cd /workspaces/${package_directory}/nsdbpg || exit 1
  make PGLIB=${pg_lib} PGINCLUDE=${pg_incl} NAVISERVER=${ns_install_dir} 2>&1 | tee -a /workspaces/logs/${package_directory}.log
  make NAVISERVER=${ns_install_dir} install 2>&1 | tee -a /workspaces/logs/${package_directory}.log

  build_cleanup
