#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSION ; set +a;

IMAGE="${IMAGE:-oupfiz5/tcl-build:${VERSION}}"

docker build \
       --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
       --build-arg VERSION="${VERSION}" \
       --build-arg S6_UBUNTU_VERSION="${S6_UBUNTU_VERSION}" \
       -t "${IMAGE}" \
       -t oupfiz5/tcl-build:latest \
       -f ../Dockerfile \
        ../.
