#!/bin/bash
set -a; source ../VERSION ; set +a;

docker build --no-cache \
       --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
       --build-arg VERSION="${VERSION}" \
       -t oupfiz5/tcl-build:${VERSION} \
       -t oupfiz5/tcl-build:latest \
       -f ../Dockerfile \
        ../.
