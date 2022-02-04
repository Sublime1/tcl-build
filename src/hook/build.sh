#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSIONS ; set +a;

IMAGE="${IMAGE:-${IMAGE_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}}"
DOCKERFILE="${DOCKERFILE:-Dockerfile}"

docker build \
       --build-arg UBUNTU_IMAGE_REPOSITORY="${UBUNTU_IMAGE_REPOSITORY}" \
       --build-arg UBUNTU_IMAGE_NAME="${UBUNTU_IMAGE_NAME}" \
       --build-arg UBUNTU_IMAGE_TAG="${UBUNTU_IMAGE_TAG}" \
       --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
       --build-arg FOSSIL_VERSION="${FOSSIL_VERSION:-2.17}" \
       -t "${IMAGE}" \
       -f ../"${DOCKERFILE}" \
        ../.
