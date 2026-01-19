
#!/bin/bash
set -euo pipefail

# shellcheck source=../src/builds/common.sh
. /builds/common.sh
  # shellcheck source=../src/builds/env-vars.sh
  . /builds/env-vars.sh
  # shellcheck disable=SC1091
  . /VERSIONS


    build_setup


  package_directory="tcl${TCL_VERSION}"
  if [ ! -d /workspaces/"${package_directory}" ]; then
      cd /workspaces || { echo "[FATAL] Failed to cd to /workspaces"; exit 10; }
      set +e
      bash /builds/tcl-download.sh
      rc=$?; echo "[DEBUG] tcl-download.sh exit code: $rc"
      if [ $rc -ne 0 ]; then echo "[FATAL] tcl-download.sh failed!"; exit 11; fi
      if [ ! -f "${package_directory}-src.tar.gz" ]; then
        echo "[FATAL] Tarball ${package_directory}-src.tar.gz not found after download!"; ls -l; exit 12;
      fi
      tar tzf "${package_directory}-src.tar.gz"
      if [ $rc -ne 0 ]; then echo "[FATAL] Tarball integrity check failed!"; exit 13; fi
      tar xfz "${package_directory}-src.tar.gz"
      if [ $rc -ne 0 ]; then echo "[FATAL] Extraction failed!"; ls -l; exit 14; fi
      set -e
  fi


  mkdir -p /workspaces/logs
  : > /workspaces/logs/"${package_directory}".log
  if [ ! -d /workspaces/"${package_directory}"/unix ]; then
    echo "[FATAL] Directory /workspaces/${package_directory}/unix does not exist before configure!"
    ls -l /workspaces/"${package_directory}"
    exit 21
  fi
  cd /workspaces/"${package_directory}"/unix || { echo "[FATAL] Failed to cd to /workspaces/${package_directory}/unix"; ls -l /workspaces/"${package_directory}"; exit 22; }
  ./configure --enable-threads --prefix="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
  make 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
  make install

  # Make sure, we have a tclsh in ns/bin
  if [ -f "${PREFIX}"/bin/tclsh ] ; then
      rm "${PREFIX}"/bin/tclsh
  fi

  ln -sf "${PREFIX}"/bin/tclsh"${TCL_VERSION%.*}" "${PREFIX}"/bin/tclsh

  build_cleanup
