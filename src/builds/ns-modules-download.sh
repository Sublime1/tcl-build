#!/bin/bash
set -euo pipefail
TARBALL="naviserver-${NS_MODULES_VERSION}-modules.tar.gz"
URL="https://downloads.sourceforge.net/sourceforge/naviserver/${TARBALL}"
if [ ! -f "$TARBALL" ]; then
    echo wget "${WGET_OPTIONS}" "$URL"
    if wget ${WGET_OPTIONS} "$URL" -O "$TARBALL"; then
        echo "[ns-modules-download.sh] Downloaded $TARBALL successfully."
        exit 0
    else
        echo "[ns-modules-download.sh] ERROR: Failed to download $TARBALL" >&2
        exit 1
    fi
else
    echo "[ns-modules-download.sh] File $TARBALL exists. Skip download."
    exit 0
fi
