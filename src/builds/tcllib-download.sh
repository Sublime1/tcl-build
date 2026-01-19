#!/bin/bash
set -euo pipefail
TARBALL="tcllib-${TCLLIB_VERSION}.tar.gz"
if [ ! -f "$TARBALL" ]; then
    URL="https://downloads.sourceforge.net/sourceforge/tcllib/tcllib-${TCLLIB_VERSION}.tar.gz"
    echo wget "${WGET_OPTIONS}" "$URL" 2>&1
    if wget ${WGET_OPTIONS} "$URL" -O "$TARBALL"; then
        echo "[tcllib-download.sh] Downloaded $TARBALL successfully."
        exit 0
    else
        echo "[tcllib-download.sh] ERROR: Failed to download $TARBALL" >&2
        exit 1
    fi
else
    echo "[tcllib-download.sh] File $TARBALL exists. Skip download."
    exit 0
fi
