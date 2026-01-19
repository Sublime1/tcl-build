#!/bin/bash
set -euo pipefail
  if [ ! -f naviserver-${NS_VERSION}.tar.gz ] ; then
    URL="https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-${NS_VERSION}.tar.gz"
    echo wget "${WGET_OPTIONS}" "$URL"
    if wget ${WGET_OPTIONS} "$URL" -O "naviserver-${NS_VERSION}.tar.gz"; then
      echo "[ns-download.sh] Downloaded naviserver-${NS_VERSION}.tar.gz successfully."
      exit 0
    else
      echo "[ns-download.sh] ERROR: Failed to download naviserver-${NS_VERSION}.tar.gz" >&2
      exit 1
    fi
  fi
  echo "[ns-download.sh] File naviserver-${NS_VERSION}.tar.gz exists. Skip download."
  exit 0
