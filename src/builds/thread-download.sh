#!/bin/bash
set -euo pipefail
TARBALL="thread${THREAD_VERSION}.tar.gz"
if [ ! -f "$TARBALL" ]; then
  URL="https://downloads.sourceforge.net/sourceforge/tcl/thread${THREAD_VERSION}.tar.gz"
  echo wget "${WGET_OPTIONS}" "$URL" 2>&1
  if wget ${WGET_OPTIONS} "$URL" -O "$TARBALL"; then
    echo "[thread-download.sh] Downloaded $TARBALL successfully."
    exit 0
  else
    echo "[thread-download.sh] ERROR: Failed to download $TARBALL" >&2
    exit 1
  fi
else
  echo "[thread-download.sh] File $TARBALL exists. Skip download."
  exit 0
fi
