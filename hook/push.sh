#!/bin/bash
set -a; source ../VERSION ; set +a;

if [[ ${BRANCH} == 'dev' ]]; then
    TAG_PREFIX='dev-'
else
    TAG_PREFIX=''
fi

docker push oupfiz5/tcl-build:${TAG_PREFIX}${VERSION:-undefine}
docker push oupfiz5/tcl-build:${TAG_PREFIX}latest
