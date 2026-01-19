#!/bin/bash
set -euo pipefail
if [ ! -f rl_json$-"{RL_JSON_VERSION}".tar.gz ] ; then
    echo "${WGET_OPTIONS}" https://github.com/RubyLane/rl_json/archive/refs/tags/"${RL_JSON_VERSION}".tar.gz
    TARBALL="rl_json-${RL_JSON_VERSION}.tar.gz"
    if wget ${WGET_OPTIONS} https://github.com/RubyLane/rl_json/archive/refs/tags/"${RL_JSON_VERSION}".tar.gz -O "$TARBALL"; then
        echo "[rl_json-download.sh] Downloaded $TARBALL successfully."
        exit 0
    else
        echo "[rl_json-download.sh] ERROR: Failed to download $TARBALL" >&2
        exit 1
    fi
fi
    echo "[rl_json-download.sh] File $TARBALL exists. Skip download."
    exit 0
