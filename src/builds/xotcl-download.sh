#!/bin/bash
set -euo pipefail
TARBALL="nsf${XOTCL_VERSION}.tar.gz"
URL="https://downloads.sourceforge.net/sourceforge/next-scripting/$TARBALL"
if [ ! -f "$TARBALL" ]; then
  echo wget "${WGET_OPTIONS}" "$URL"
  if wget ${WGET_OPTIONS} "$URL" -O "$TARBALL"; then
    echo "[xotcl-download.sh] Downloaded $TARBALL successfully."
    exit 0
  else
    echo "[xotcl-download.sh] ERROR: Failed to download $TARBALL" >&2
    exit 1
  fi
else
  echo "[xotcl-download.sh] File $TARBALL exists. Skip download."
  exit 0
fi
