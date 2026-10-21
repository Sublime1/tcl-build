#!/bin/bash
# shellcheck disable=SC1091
set -a; source ../VERSIONS ; set +a;

IMAGE="${IMAGE:-${IMAGE_REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}}"
IMAGE_LATEST="${IMAGE_LATEST:-${IMAGE_REPOSITORY}/${IMAGE_NAME}:latest}"
DOCKERFILE="${DOCKERFILE:-Dockerfile}"
BUILDKIT_CACHE_DIR="${BUILDKIT_CACHE_DIR:-../.buildx-cache}"
BUILDKIT_CACHE_MODE="${BUILDKIT_CACHE_MODE:-max}"
USE_LOCAL_CACHE="${USE_LOCAL_CACHE:-auto}"

BUILDX_DRIVER="$(docker buildx inspect --bootstrap 2>/dev/null | awk '/^Driver:/ { print $2; exit }')"

CACHE_ARGS=()
if [ "${USE_LOCAL_CACHE}" = "1" ] || { [ "${USE_LOCAL_CACHE}" = "auto" ] && [ -n "${BUILDX_DRIVER}" ] && [ "${BUILDX_DRIVER}" != "docker" ]; }; then
    mkdir -p "${BUILDKIT_CACHE_DIR}"
    CACHE_ARGS=(
        --cache-from "type=local,src=${BUILDKIT_CACHE_DIR}"
        --cache-to "type=local,dest=${BUILDKIT_CACHE_DIR},mode=${BUILDKIT_CACHE_MODE}"
    )
else
    echo "Info: local build cache disabled for buildx driver '${BUILDX_DRIVER:-unknown}'."
fi

BUILD_ARGS=(
    "${CACHE_ARGS[@]}"
    --build-arg UBUNTU_IMAGE_REPOSITORY="${UBUNTU_IMAGE_REPOSITORY}"
    --build-arg UBUNTU_IMAGE_NAME="${UBUNTU_IMAGE_NAME}"
    --build-arg UBUNTU_IMAGE_TAG="${UBUNTU_IMAGE_TAG}"
    --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
    --build-arg FOSSIL_VERSION="${FOSSIL_VERSION:-2.21}"
    --build-arg CMAKE_VERSION="${CMAKE_VERSION}"
    --tag "${IMAGE}"
    --tag "${IMAGE_LATEST}"
    --file ../"${DOCKERFILE}"
    ../.
)

if [ "${NO_CACHE:-0}" = "1" ]; then
    BUILD_ARGS=(--no-cache "${BUILD_ARGS[@]}")
fi

docker buildx build "${BUILD_ARGS[@]}"

# Let everyone know we are finished!
for i in {1..10}; do
    echo -e "\a"
    sleep 0.5   
done