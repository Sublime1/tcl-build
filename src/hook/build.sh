#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSIONS ; set +a;

IMAGE="${IMAGE:-oupfiz5/tcl-build:${TCL_BUILD_IMAGE_TAG}}"

docker build \
       --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
       --build-arg VERSION="${VERSION}" \
       --build-arg S6_UBUNTU_TAG="${S6_UBUNTU_TAG}" \
       -t "${IMAGE}" \
       -f ../Dockerfile \
        ../.
