#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSIONS ; set +a;

IMAGE="${IMAGE:-${IMAGE_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}}"
IMAGE_LATEST="${IMAGE_LATEST:-${IMAGE_REPOSITORY}/${IMAGE_NAME}:latest}"
DOCKERFILE="${DOCKERFILE:-Dockerfile}"

docker buildx build \
    --build-arg UBUNTU_IMAGE_REPOSITORY="${UBUNTU_IMAGE_REPOSITORY}" \
    --build-arg UBUNTU_IMAGE_NAME="${UBUNTU_IMAGE_NAME}" \
    --build-arg UBUNTU_IMAGE_TAG="${UBUNTU_IMAGE_TAG}" \
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
    --build-arg FOSSIL_VERSION="${FOSSIL_VERSION:-2.21}" \
    --tag "${IMAGE}" \
    --tag "${IMAGE_LATEST}" \
    --file ../"${DOCKERFILE}" \
    ../.
