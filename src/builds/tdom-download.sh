#!/bin/bash
set -euo pipefail
  if [ ! -f tdom-"${TDOM_VERSION}"-src.tgz ] ; then
      echo wget "${WGET_OPTIONS}" http://tdom.org/downloads/tdom-"${TDOM_VERSION}"-src.tgz
    TARBALL="tdom-${TDOM_VERSION}-src.tgz"
    if wget ${WGET_OPTIONS} http://tdom.org/downloads/tdom-"${TDOM_VERSION}"-src.tgz -O "$TARBALL"; then
      echo "[tdom-download.sh] Downloaded $TARBALL successfully."
      exit 0
    else
      echo "[tdom-download.sh] ERROR: Failed to download $TARBALL" >&2
      exit 1
    fi
  fi
  echo "[tdom-download.sh] File $TARBALL exists. Skip download."
  exit 0
