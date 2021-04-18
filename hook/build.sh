#!/bin/bash
set -a; source ../VERSION ; set +a;

if [[ ${BRANCH} == 'dev' ]]; then
    BRANCH='dev-'
else
    BRANCH=""
fi

docker push oupfiz5/tcl-build:${BRANCH}${VERSION:-undefine}
docker push oupfiz5/tcl-build:${BRANCH}latest

docker build --no-cache \
       --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
       --build-arg VERSION="${VERSION}" \
       -t oupfiz5/tcl-build:${BRANCH}${VERSION:-undefine} \
       -t oupfiz5/tcl-build:${BRANCH}latest \
       -f ../Dockerfile \
        ../.
