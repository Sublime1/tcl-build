#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSIONS ; set +a;

IMAGE="${IMAGE:-oupfiz5/tcl-build:${TCL_BUILD_IMAGE_TAG}}"

docker push "${IMAGE}"
