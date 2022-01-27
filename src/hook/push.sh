#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSION ; set +a;

IMAGE="${IMAGE:-oupfiz5/tcl-build:${VERSION}}"

docker push "${IMAGE}"
