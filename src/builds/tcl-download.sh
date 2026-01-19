#!/bin/bash
set -euo pipefail
TARBALL="tcl${TCL_VERSION}-src.tar.gz"
if [ ! -f "$TARBALL" ]; then
    echo wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/$TARBALL 2>&1
    if wget ${WGET_OPTIONS} https://downloads.sourceforge.net/sourceforge/tcl/$TARBALL; then
        echo "[tcl-download.sh] Downloaded $TARBALL successfully."
        exit 0
    else
        echo "[tcl-download.sh] ERROR: Failed to download $TARBALL" >&2
        exit 1
    fi
else
    echo "[tcl-download.sh] File $TARBALL exists. Skip download."
    exit 0
fi
