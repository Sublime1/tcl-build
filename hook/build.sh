#!/bin/bash
docker build \
       --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
       -t oupfiz5/tcl-build:20.04 \
       -t oupfiz5/tcl-build:latest \
       -f ../Dockerfile \
        ../.
