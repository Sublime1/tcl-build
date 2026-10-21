# syntax=docker/dockerfile:1.4

# * Arguments
ARG \
    BUILD_DATE="${BUILD_DATE}" \
    CMAKE_VERSION="${CMAKE_VERSION}" \
    FOSSIL_VERSION="${FOSSIL_VERSION}" \
    UBUNTU_IMAGE_NAME="${UBUNTU_IMAGE_NAME}" \
    UBUNTU_IMAGE_REPOSITORY="${UBUNTU_IMAGE_REPOSITORY}" \
    UBUNTU_IMAGE_TAG="${UBUNTU_IMAGE_TAG}" \
    NS_VERSION="${NS_VERSION}" \
    NS_MODULES_VERSION="${NS_MODULES_VERSION}" \
    RL_JSON_VERSION="${RL_JSON_VERSION}" \
    TCL_VERSION="${TCL_VERSION}" \
    TCLLIB_VERSION="${TCLLIB_VERSION}" \
    THREAD_VERSION="${THREAD_VERSION}" \
    XOTCL_VERSION="${XOTCL_VERSION}" \
    TDOM_VERSION="${TDOM_VERSION}"

FROM ${UBUNTU_IMAGE_REPOSITORY}/${UBUNTU_IMAGE_NAME}:${UBUNTU_IMAGE_TAG}

# ** Environments
ENV \
    FOSSIL_VERSION=${FOSSIL_VERSION} \
    NS_VERSION=${NS_VERSION} \
    NS_MODULES_VERSION=${NS_MODULES_VERSION} \
    RL_JSON_VERSION=${RL_JSON_VERSION} \
    TCL_VERSION=${TCL_VERSION} \
    TCLLIB_VERSION=${TCLLIB_VERSION} \
    THREAD_VERSION=${THREAD_VERSION} \
    XOTCL_VERSION=${XOTCL_VERSION} \
    TDOM_VERSION=${TDOM_VERSION}

# * Labels
LABEL \
    maintainer="Oupfiz V <oupfiz5@yandex.ru>" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.authors="Oupfiz V (Five)" \
    org.opencontainers.image.url="https://chiselapp.com/user/oupfiz5/repository/tcl-build/home" \
    org.opencontainers.image.documentation="https://chiselapp.com/user/oupfiz5/repository/tcl-build/wiki" \
    org.opencontainers.image.source="https://chiselapp.com/user/oupfiz5/repository/tcl-build/brlist" \
    org.opencontainers.image.version="0.0.3d" \
    org.opencontainers.image.revision="" \
    org.opencontainers.image.vendor="" \
    org.opencontainers.image.licenses="" \
    org.opencontainers.image.ref.name="" \
    org.opencontainers.image.title="Ubuntu image for build tcl packages" \
    org.opencontainers.image.description="Ubuntu image for build tcl packages" \
    org.opencontainers.tclbuild.version="${VERSION}"

# * Environment

# * Copy scripts
COPY builds /builds
COPY VERSIONS /VERSIONS

ARG \
    CMAKE_VERSION="${CMAKE_VERSION}" \
    FOSSIL_VERSION="${FOSSIL_VERSION}"

# * Run
# hadolint ignore=DL3008,DL3003
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    export LANG="C.UTF-8" && export LC_ALL="C.UTF-8" \
        && printf '%s\n' \
             'Acquire::Retries "3";' \
             'Acquire::http::Timeout "20";' \
             'Acquire::https::Timeout "20";' \
             'Acquire::http::Pipeline-Depth "0";' \
             'Acquire::Queue-Mode "access";' \
             > /etc/apt/apt.conf.d/99tclbuild-network \
    && export DEBIAN_FRONTEND=noninteractive \
        && for i in 1 2; do \
                 apt-get update && apt-get -y install --no-install-recommends --fix-missing \
               apt-utils \
               autoconf \
               automake \
               bash \
               curl \
               gcc \
               gdb \
               git \
               gnupg \
               libboost-all-dev \
               libbsd-dev \
               libcurl4-openssl-dev \
               libgd-dev \
               libgeos-dev \
               libmemcached-dev \
               libpq-dev \
               libproj-dev \
               libreadline-dev \
               libssl-dev \
               libtool \
               libuv1-dev \
               libxml2-dev \
               libxslt-dev \
               libyajl-dev \
               libzookeeper-mt-dev \
               locales \
               lsb-release \
               make \
               minizip \
               openssl \
               pandoc \
               pipx \
               pkg-config \
               python3-pip \
               python3-venv \
               swig \
               tzdata \
               wget \
                             zlib1g-dev \
                 && break; \
                 if [ "${i}" -eq 3 ]; then \
                     echo "apt failed after ${i} attempts"; \
                     exit 1; \
                 fi; \
                 echo "apt failed on attempt ${i}, retrying..."; \
                 rm -rf /var/lib/apt/lists/*; \
             done \
    && pipx ensurepath \
    && pipx install "cmake==${CMAKE_VERSION}" \
    && sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen \
    && printf 'LANG=en_US.UTF-8\nLC_ALL=en_US.UTF-8\n' > /etc/default/locale \
    && cd /tmp \
    && wget --tries=3 --waitretry=2 --timeout=20 -O /tmp/fossil-linux.tar.gz https://www.fossil-scm.org/home/uv/fossil-linux-x64-${FOSSIL_VERSION}.tar.gz \
    && tar xzf /tmp/fossil-linux.tar.gz -C /usr/bin \
    # Purge all the build-time packages we used.
    # --auto-remove will also remove their dependencies.
    && apt-get purge -y --auto-remove \
               apt-utils \
               curl \
               gdb \
               gnupg \
               libboost-all-dev \
               lsb-release \
               minizip \
               pipx  \
               python3-pip \
               python3-venv \
    && apt-get clean \
    && rm -rf /tmp/*

# * Entrypoint 
ENTRYPOINT ["/init"]
