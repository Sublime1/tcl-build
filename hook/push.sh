#!/bin/bash
set -a; source ../VERSION ; set +a;

if [[ ${BRANCH} == 'dev' ]]; then
    BRANCH='dev-'
else
    BRANCH=""
fi

docker push oupfiz5/tcl-build:${BRANCH}${VERSION:-undefine}
docker push oupfiz5/tcl-build:${BRANCH}latest
