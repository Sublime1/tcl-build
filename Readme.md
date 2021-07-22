# Table of Contents

-   [About](#about)
-   [Prerequisite](#prerequisite)
    -   [Tools](#tools)
    -   [Third party tools](#third-party-tools)
-   [Installation](#installation)
    -   [Download from dockerhub](#download-from-dockerhub)
    -   [Build from chiselapp (fossil)](#build-from-chiselapp--fossil-)
    -   [Build from github](#build-from-github)
    -   [Configuration](#configuration)
        -   [Build arguments](#build-arguments)
        -   [Example of build](#example-of-build)
-   [Configuration options](#configuration-options)
    -   [General options](#general-options)
    -   [Timezone](#timezone)
-   [Applications](#applications)
    -   [Configuration](#configuration)
-   [Usage](#usage)
    -   [Builder](#builder)
    -   [Build applications](#build-applications)
-   [Prepare source packages](#prepare-source-packages)
-   [Continues Integration](#continues-integration)
-   [Maintenance](#maintenance)
    -   [Log output](#log-output)
    -   [Shell access](#shell-access)
-   [Code](#code):code:
    -   [VERSION](#version):code:
    -   [../.fossil-settings/crlf-glob](#----fossil-settings-crlf-glob)
    -   [../.fossil-settings/crlf-glob.no-warn](#----fossil-settings-crlf-glob-no-warn):code:
    -   [../.fossil-settings/ignore-glob](#----fossil-settings-ignore-glob):code:
    -   [../.fossil-settings/ignore-glob.no-warn](#----fossil-settings-ignore-glob-no-warn):code:
    -   [../.github/workflows/on-push.yaml](#----github-workflows-on-push-yaml):code:
    -   [../.github/workflows/test.yaml](#----github-workflows-test-yaml):code:
    -   [../.github/.trigger\_on\_push](#----github--trigger-on-push):code:
    -   [../.gitignore](#----gitignore):code:
    -   [Dockerfile](#dockerfile):code:
    -   [hook/build.sh](#hook-build-sh):code:
    -   [hook/push.sh](#hook-push-sh):code:
    -   [rootfs/etc/cont-finish.d/.gitignore](#rootfs-etc-cont-finish-d--gitignore):code:
    -   [rootfs/etc/cont-init.d/00\_settimezone.sh](#rootfs-etc-cont-init-d-00-settimezone-sh):code:
    -   [rootfs/etc/fix-attrs.d/.gitignore](#rootfs-etc-fix-attrs-d--gitignore):code:
    -   [rootfs/etc/services.d/.gitignore](#rootfs-etc-services-d--gitignore):code:
    -   [builds/common.sh](#builds-common-sh):code:
    -   [builds/all-build.sh](#builds-all-build-sh):code:
    -   [builds/env-vars.sh](#builds-env-vars-sh):code:
    -   [builds/ns-build.sh](#builds-ns-build-sh):code:
    -   [builds/ns-download.sh](#builds-ns-download-sh):code:
    -   [builds/ns-modules-download.sh](#builds-ns-modules-download-sh):code:
    -   [builds/ns-modules-build-nsdbpg.sh](#builds-ns-modules-build-nsdbpg-sh):code:
    -   [builds/ns-modules-build-nsstats.sh](#builds-ns-modules-build-nsstats-sh):code:
    -   [builds/ns-modules-build-nsconf.sh](#builds-ns-modules-build-nsconf-sh):code:
    -   [builds/tcl-build.sh](#builds-tcl-build-sh):code:
    -   [builds/tcl-download.sh](#builds-tcl-download-sh):code:
    -   [builds/tcllib-build.sh](#builds-tcllib-build-sh):code:
    -   [builds/tcllib-download.sh](#builds-tcllib-download-sh):code:
    -   [builds/thread-build.sh](#builds-thread-build-sh):code:
    -   [builds/thread-download.sh](#builds-thread-download-sh):code:
    -   [builds/tdom-build.sh](#builds-tdom-build-sh):code:
    -   [builds/tdom-download.sh](#builds-tdom-download-sh):code:
    -   [builds/xotcl-build.sh](#builds-xotcl-build-sh):code:
    -   [builds/xotcl-download.sh](#builds-xotcl-download-sh):code:
    -   [builds/rl\_json-build.sh](#builds-rl-json-build-sh):code:
    -   [builds/rl\_json-download.sh](#builds-rl-json-download-sh):code:



<a id="about"></a>

# About

This is [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay) for buid tcl software. The basic idea was taken from [tcl2020-build](https://github.com/tcl2020/tcl2020-build) .

Tcl-build is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/tcl-build>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting tcl-build repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about tcl-build, visit the official self-hosting site linked above.


<a id="prerequisite"></a>

# Prerequisite


<a id="tools"></a>

## Tools

1.  \*nix operation system
2.  Install Docker
3.  Install git (optional)
4.  Install fossil (optional)


<a id="third-party-tools"></a>

## Third party tools

They are using for testing and scanning:

1.  [BATS](https://github.com/bats-core)
2.  [Shellcheck](https://github.com/koalaman/shellcheck/)
3.  [Hadolynt](https://github.com/hadolint/hadolint)
4.  [Dockle](https://github.com/goodwithtech/dockle)
5.  Snyk (todo)
6.  Trivy (todo)


<a id="installation"></a>

# Installation


<a id="download-from-dockerhub"></a>

## Download from dockerhub

    docker pull oupfiz5/tcl-build:latest
    docker pull oupfiz5/tcl-build:21.07


<a id="build-from-chiselapp--fossil-"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/tcl-build tcl-build.fossil
    mkdir tcl-build
    cd tcl-build
    fossil open ../tcl-build.fossil
    docker build -t oupfiz5/tcl-build .


<a id="build-from-github"></a>

## Build from github

    git clone https://github.com/oupfiz5/tcl-build.git
    cd tcl-build
    docker build -t oupfiz5/tcl-build .


<a id="configuration"></a>

## Configuration


<a id="build-arguments"></a>

### Build arguments

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Arguments</th>
<th scope="col" class="org-left">Default</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">BUILD_DATE</td>
<td class="org-left">none</td>
<td class="org-left">Set build date for label</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">FOSSIL_VERSION</td>
<td class="org-left">2.15.1</td>
<td class="org-left">Set upload fossil version</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">VERSION</td>
<td class="org-left">none</td>
<td class="org-left">Set version for label</td>
</tr>
</tbody>
</table>


<a id="example-of-build"></a>

### Example of build

    docker build \
           --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
           --build-arg VERSION='21.04' \
           --build-arg FOSSIL_VERSION='2.15.1' \
           -t oupfiz5/tcl-build:21.04 \
           -t oupfiz5/tcl-build:latest \
           -f ./Dockerfile \
            .


<a id="configuration-options"></a>

# Configuration options

For configuration is using environment variables.


<a id="general-options"></a>

## General options

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Option</th>
<th scope="col" class="org-left">Default</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">TZ</td>
<td class="org-left">UTC</td>
<td class="org-left">Set timezone, example Europe/Moscow</td>
</tr>
</tbody>
</table>


<a id="timezone"></a>

## Timezone

Set the timezone for the container, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    mkdir -p $PWD/workspaces
    docker run -itd \
        -v $PWD/workspaces:/workspaces\
        -v $PWD/builds:/builds \
        --env 'TZ=Europe/Moscow' \
        --name=tcl-build \
        oupfiz5/tcl-build:latest


<a id="applications"></a>

# Applications

The docker support builds for  the following applications:

-   tcl
-   tcllib
-   rl\_json
-   NaviServer (modules)
-   tDOM
-   xotcl


<a id="configuration"></a>

## Configuration

For configuration is using docker environment variable and/or `builds/env-vars.sh`

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Option</th>
<th scope="col" class="org-right">Default</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">PREFIX</td>
<td class="org-right">/usr</td>
<td class="org-left">Default values for prefix</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">NS_VERSION</td>
<td class="org-right">4.99.21</td>
<td class="org-left">Define NaviServer version</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">NS_MODULES_VERSION</td>
<td class="org-right">4.99.21</td>
<td class="org-left">Define NaviServer modules version</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">RL_JSON_VERSION</td>
<td class="org-right">0.11.0</td>
<td class="org-left">Define <a href="https://github.com/RubyLane/rl_json">RL_JSON</a> version</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">TCL_VERSION</td>
<td class="org-right">8.6.11</td>
<td class="org-left">Define tcl version</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">TCLLIB_VERSION</td>
<td class="org-right">1.20</td>
<td class="org-left">Define tcl lib version</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">TDOM_VERSION</td>
<td class="org-right">0.9.1</td>
<td class="org-left">Define tdom version</td>
</tr>
</tbody>

<tbody>
<tr>
<td class="org-left">XOTCL_VERSION</td>
<td class="org-right">2.3.0</td>
<td class="org-left">Define xotcl version</td>
</tr>
</tbody>
</table>


<a id="usage"></a>

# Usage


<a id="builder"></a>

## Builder

Run the build container in the background with Docker:

    mkdir -p $PWD/workspaces
    docker run -itd \
        -v $PWD/workspaces:/workspaces\
        -v $PWD/builds:/builds \
        --name=tcl-build \
        oupfiz5/tcl-build:latest


<a id="build-applications"></a>

## Build applications

Build all program in tcl-build using a `docker exec` and default congratulations:

    docker exec -it tcl-build bash /builds/all-build.sh

Build any applications with version customization in tcl-build using `docker exec`. For example install tcl version 8.6.10 is:

    docker exec -it \
           -e TCL_VERSION=8.6.10 \
           tcl-build \
           bash /builds/tcl-build.sh

Modify the source code of any package in the workspaces directory. Then you can use make, cmake, &#x2026; to rebuild the container with the changes.  Use the build container with your favorite IDE.


<a id="prepare-source-packages"></a>

# Prepare source packages

Source packages are added to the Docker image using the `builds/build-all.sh` script.

To add packages or features create a two shell scripts in `builds` directory.  One shell script will download the source package: `yourpackage-download.sh`. The other script will build the package: `yourpackage-build.sh`.  Add your new build script, `yourpackage-build.sh`, to `builds/all-build.sh`.


<a id="continues-integration"></a>

# Continues Integration

For  build and push docker images using  [Github Actions workflow](https://github.com/oupfiz5/build-tcl/blob/master/.github/workflows/on-push.yaml). Flow process is [GitHub flow](https://guides.github.com/introduction/flow/).


<a id="maintenance"></a>

# Maintenance


<a id="log-output"></a>

## Log output

For debugging and maintenance purposes you may want access the output log. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker interactive:

    docker run -it --rm \
           --name=tcl-build \
           oupfiz5/tcl-build:latest \
           /bin/bash


<a id="shell-access"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are usingDocker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it tcl-build /bin/bash


<a id="code"></a>

# Code     :code:


<a id="version"></a>

## VERSION     :code:

    VERSION=21.07
    S6_UBUNTU_VERSION=20.04


<a id="----fossil-settings-crlf-glob"></a>

## ../.fossil-settings/crlf-glob

    *


<a id="----fossil-settings-crlf-glob-no-warn"></a>

## ../.fossil-settings/crlf-glob.no-warn     :code:

    *


<a id="----fossil-settings-ignore-glob"></a>

## ../.fossil-settings/ignore-glob     :code:

    .git/
    .github-mirroring/*
    docs/
    org/.configuration/*
    tests/.bats-battery/*/.git
    tests/.bats-battery/*/.github
    workspaces/


<a id="----fossil-settings-ignore-glob-no-warn"></a>

## ../.fossil-settings/ignore-glob.no-warn     :code:

    *


<a id="----github-workflows-on-push-yaml"></a>

## ../.github/workflows/on-push.yaml     :code:

    name: Build and push docker images

    on:
      push:
        branches:
          - master
          - main
        paths:
          - '.github/workflows/*'
          - '.github/*'
          - 'src/Dockerfile'
          - 'src/rootfs/*'
          - 'src/hook/*'
          - 'src/*.sh'
          - 'tests/**'
      pull_request:
        branches:
          - master
          - main
        paths:
          - '.github/workflows/*'
          - '.github/*'
          - 'src/Dockerfile'
          - 'src/rootfs/*'
          - 'src/hook/*'
          - 'src/*.sh'
          - 'tests/**'

    jobs:
      build:
        name: Build and push image to dockerhub
        runs-on: ubuntu-latest
        steps:
          - name: Repo checkout
            uses: actions/checkout@v2

          - name: Login to DockerHub Registry
            run: |
              echo  ${{ secrets.DOCKERHUB_TOKEN }} | docker login --username ${{ secrets.DOCKERHUB_USERNAME }} --password-stdin

          - name: Build images
            run: |
              cd ${GITHUB_WORKSPACE}/src/hook
              ./build.sh

          - name: Push images
            run: |
              cd ${GITHUB_WORKSPACE}/src/hook
              ./push.sh


<a id="----github-workflows-test-yaml"></a>

## ../.github/workflows/test.yaml     :code:

    name: Tests

    # * Controls
    # Controls when the action will run.
    on:
      push:
        paths:
          - '.github/workflows/*'
          - '.github/*'
          - 'src/Dockerfile'
          - 'src/rootfs/*'
          - 'src/hook/*'
          - 'src/builds/*'
          - 'src/*.sh'
          - 'tests/**'
        branches-ignore:
          - 'master'
          - 'main'
      pull_request:
        paths:
          - '.github/workflows/*'
          - '.github/*'
          - 'src/Dockerfile'
          - 'src/rootfs/*'
          - 'src/hook/*'
          - 'src/builds/*'
          - 'src/*.sh'
          - 'tests/**'
        branches-ignore:
          - 'master'
          - 'main'
      workflow_dispatch:

    # * Environments
    env:
      CONTAINER_NAME: "tcl-build"
      IMAGE_NAME: "tcl-build"
      IMAGE_TAG: "${{ github.sha }}"
      REPOSITORY: "oupfiz5"

    # * Jobs
    jobs:
      checks:
        name: Checks
        runs-on: ubuntu-20.04
        steps:
          - name: Repo checkout
            uses: actions/checkout@v2

          - name: Check shell files (shellcheck)
            run: |
              sudo apt-get update -y
              sudo apt-get install shellcheck
              cd ${GITHUB_WORKSPACE}/tests
              .bats-battery/bats-core/bin/bats 01.shellchecks.bats

          - name: Check Dockerfile (hadolint)
            run: |
              cd ${GITHUB_WORKSPACE}/tests
              .bats-battery/bats-core/bin/bats 02.dockerfile_check.bats

          - name: Build image
            run: |
              cd ${GITHUB_WORKSPACE}/src
              set -a; source VERSION ; set +a;
              export IMAGE="${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"
              docker build \
              --build-arg BUILD_DATE="$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
              --build-arg VERSION="${VERSION}" \
              --build-arg S6_UBUNTU_VERSION="${S6_UBUNTU_VERSION}" \
              -t "${IMAGE}" \
              -t oupfiz5/tcl-build:latest \
              -f ../Dockerfile \
              .

          - name: Check docker image (dockle)
            run: |
              cd ${GITHUB_WORKSPACE}/tests
              export IMAGE="${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"
              .bats-battery/bats-core/bin/bats 03.docker_image_check.bats

          - name: Check docker container
            run: |
              cd ${GITHUB_WORKSPACE}/tests
              export IMAGE="${REPOSITORY}/${IMAGE_NAME}:${IMAGE_TAG}"
              .bats-battery/bats-core/bin/bats 04.container_check.bats


<a id="----github--trigger-on-push"></a>

## ../.github/.trigger\_on\_push     :code:

    Trigger: 3


<a id="----gitignore"></a>

## ../.gitignore     :code:

    .fslckout
    .projectile
    /workspaces/*
    .fossil-settings/*


<a id="dockerfile"></a>

## Dockerfile     :code:

    # * Base image
    ARG S6_UBUNTU_VERSION=20.04
    FROM oupfiz5/ubuntu-s6:${S6_UBUNTU_VERSION}

    # * Arguments
    ARG BUILD_DATE \
        VERSION \
        FOSSIL_VERSION=2.16

    # ** Environments
    ENV NS_VERSION=${NS_VERSION} \
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
        org.opencontainers.image.version="0.0.2d" \
        org.opencontainers.image.revision="" \
        org.opencontainers.image.vendor="" \
        org.opencontainers.image.licenses="" \
        org.opencontainers.image.ref.name="" \
        org.opencontainers.image.title="Ubuntu image for build tcl packages" \
        org.opencontainers.image.description="Ubuntu image for build tcl packages" \
        org.opencontainers.tclbuild.version="${VERSION}"

    # * Environment

    # * Copy
    COPY rootfs/ /

    # * Copy builds scripts
    COPY builds /builds

    # * Add
    ADD https://www.fossil-scm.org/home/uv/fossil-linux-x64-${FOSSIL_VERSION}.tar.gz /tmp/fossil-linux.tar.gz

    # * Run
    # hadolint ignore=DL3008,DL3003
    RUN export LANG="en_US.UTF-8" && export LC_ALL="en_US.UTF-8" \
        && apt-get update \
        && export DEBIAN_FRONTEND=noninteractive \
        && apt-get -y install --no-install-recommends \
                   apache2 \
                   apache2-dev \
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
                   pkg-config \
                   postgresql-client \
                   python3-pip \
                   python3-venv \
                   swig3.0 \
                   tzdata \
                   wget \
                   zlib1g-dev \
        && pip3 install --no-cache-dir "cmake==3.17.2" \
        && locale-gen "en_US.UTF-8" \
        && update-locale LANG="en_US.UTF-8" \
        && update-locale LC_ALL="en_US.UTF-8" \
        && cd /tmp \
        && tar xzf /tmp/fossil-linux.tar.gz -C /usr/bin \
        && rm /tmp/fossil-linux.tar.gz \
        && apt-get clean \
        && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/apt/*

    # * Entrypoint
    ENTRYPOINT ["/init"]


<a id="hook-build-sh"></a>

## hook/build.sh     :code:

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


<a id="hook-push-sh"></a>

## hook/push.sh     :code:

    # shellcheck disable=SC1091
    set -a; source ../VERSION ; set +a;

    IMAGE="${IMAGE:-oupfiz5/tcl-build:${VERSION}}"

    docker push "${IMAGE}"
    docker push oupfiz5/tcl-build:latest


<a id="rootfs-etc-cont-finish-d--gitignore"></a>

## rootfs/etc/cont-finish.d/.gitignore     :code:


<a id="rootfs-etc-cont-init-d-00-settimezone-sh"></a>

## rootfs/etc/cont-init.d/00\_settimezone.sh     :code:

    # shellcheck shell=sh
    set -e

    # * User parameters
    TIMEZONE=${TZ:="UTC"}

    TZFILE="../usr/share/zoneinfo/${TIMEZONE}"

    # * Work from the /etc directory
    cd /etc

    if [ -f ${TZFILE} ]; then  # Make sure the file exists
       echo "Setting timezone to ${TIMEZONE}"
       ln -sf ${TZFILE} localtime  # Set the timezone
    else
       echo "Timezone: ${TIMEZONE} not found, skipping"
    fi


<a id="rootfs-etc-fix-attrs-d--gitignore"></a>

## rootfs/etc/fix-attrs.d/.gitignore     :code:


<a id="rootfs-etc-services-d--gitignore"></a>

## rootfs/etc/services.d/.gitignore     :code:


<a id="builds-common-sh"></a>

## builds/common.sh     :code:

    # shellcheck shell=bash
    # Helper functions for build scripts

    # export TCLSH="tclsh8.6"
    export TCLLIBPATH=/usr/lib/tcl8.6/library
    # export TCL_CONFIG="/workspaces/tcl/unix/tclConfig.sh"

    build_setup () {
        if [ ! -d /workspaces ]; then
            echo "Missing /workspaces directory."
            echo "Be sure to docker run -v ${WORK_DIR_PATH}:/workspaces ..."
            exit 1
        fi
    }

    build_git_clone () {
        local name="$1"
        local repo="$2"
        local extra="$3"
        if [ ! -d "/workspaces/$name" ]; then
            echo "No git clone of $name found".
            cd /workspaces || exit 1
            echo git clone "$extra" "$repo"
            git clone "${extra}" "$repo"
        fi
    }


    build_cleanup () {
        # fix any permissions messed up by the Docker user id
        # allow edits to the source outside of the container
        find "$(readlink -f /workspaces)" -type d -print0 | xargs -0 chmod go+rwx
        find "$(readlink -f /workspaces)" -type f -print0 | xargs -0 chmod go+rw
    }


<a id="builds-all-build-sh"></a>

## builds/all-build.sh     :code:

    sh /builds/tcl-build.sh
    sh /builds/tcllib-build.sh
    sh /builds/ns-build.sh
    sh /builds/ns-modules-build-nsdbpg.sh
    sh /builds/ns-modules-build-nsstats.sh
    sh /builds/ns-modules-build-nsconf.sh
    sh /builds/thread-build.sh
    sh /builds/xotcl-build.sh
    sh /builds/tdom-build.sh
    sh /builds/rl_json-build.sh


<a id="builds-env-vars-sh"></a>

## builds/env-vars.sh     :code:

    export PREFIX="${PREFIX:-/usr}"

    # * Versions
    export NS_VERSION="${NS_VERSION:-4.99.21}"
    export NS_MODULES_VERSION="${NS_MODULES_VERSION:-4.99.21}"
    export RL_JSON_VERSION="${RL_JSON_VERSION:-0.11.0}"
    export TDOM_VERSION="${TDOM_VERSION:-0.9.1}"
    export THREAD_VERSION="${THREAD_VERSION:-2.8.6}"
    export TCL_VERSION="${TCL_VERSION:-8.6.11}"
    export TCLLIB_VERSION="${TCLLIB_VERSION:-1.20}"
    export XOTCL_VERSION="${XOTCL_VERSION:-2.3.0}"

    # * Options
    export WGET_OPTIONS="${WGET_OPTIONS:-""}"

    # * NaviServer
    # Using for NaviServer
    # the pg_* variables should be the path leading to the include and
    # library file of postgres to be used in this build.  In particular,
    # "libpq-fe.h" and "libpq.so" are typically needed.
    export PG_INCL="/usr/include/postgresql"
    export PG_LIB="/usr/lib"


<a id="builds-ns-build-sh"></a>

## builds/ns-build.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

    package_directory="naviserver-${NS_VERSION}"
    if [ ! -d /workspaces/"${package_directory}" ]; then
        cd /workspaces && sh /builds/ns-download.sh
        tar zxvf naviserver-"${NS_VERSION}".tar.gz
    fi

    mkdir -p /workspaces/logs
    : > /workspaces/logs/"${package_directory}".log
    echo "Running the autoconf configure in /workspaces/${package_directory}"
    cd /workspaces/"${package_directory}" || exit 1
    ./configure --enable-threads --with-tcl="${PREFIX}"/lib --prefix="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    # ./configure --with-tcl=${PREFIX}/lib --prefix=${PREFIX} 2>&1 | tee -a /workspaces/logs/${package_directory}.log

    echo "Building Naviserver"
    # cut down on the output to stdout to make Travis-CI consoles faster
    #make install 2>&1 | tee -a /workspaces/logs/${package_directory}.log | cut -c1-64
    export PATH="$PATH:${PREFIX}/bin"
    make build-doc  2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

    build_cleanup


<a id="builds-ns-download-sh"></a>

## builds/ns-download.sh     :code:

    if [ ! -f naviserver-"${NS_VERSION}".tar.gz ] ; then
        echo wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-"${NS_VERSION}".tar.gz
        wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-"${NS_VERSION}".tar.gz
    fi


<a id="builds-ns-modules-download-sh"></a>

## builds/ns-modules-download.sh     :code:

    if [ ! -f naviserver-"${NS_MODULES_VERSION}"-modules.tar.gz ] ; then
        wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/naviserver/naviserver-"${NS_MODULES_VERSION}"-modules.tar.gz
    fi


<a id="builds-ns-modules-build-nsdbpg-sh"></a>

## builds/ns-modules-build-nsdbpg.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

      build_setup

    package_directory="naviserver-${NS_MODULES_VERSION}-modules"
      if [ ! -d /workspaces/"${package_directory}" ]; then
          cd /workspaces && sh /builds/ns-modules-download.sh
          tar zxvf naviserver-"${NS_MODULES_VERSION}"-modules.tar.gz --transform s/modules/naviserver-"${NS_MODULES_VERSION}"-modules/
      fi

      mkdir -p /workspaces/logs
      : > /workspaces/logs/"${package_directory}".log
      echo "Running in /workspaces/${package_directory}/nsdbpg"
      cd /workspaces/"${package_directory}"/nsdbpg || exit 1
      make PGLIB="${PG_LIB}" PGINCLUDE="${PG_INCL}" NAVISERVER="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
      make NAVISERVER="${PREFIX}" install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

      build_cleanup


<a id="builds-ns-modules-build-nsstats-sh"></a>

## builds/ns-modules-build-nsstats.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

    package_directory="naviserver-${NS_MODULES_VERSION}-modules"
    module_name='nsstats'

    if [ ! -d /workspaces/"${package_directory}" ]; then
        cd /workspaces && sh /builds/ns-modules-download.sh
        tar zxvf naviserver-"${NS_MODULES_VERSION}"-modules.tar.gz --transform s/modules/naviserver-"${NS_MODULES_VERSION}"-modules/
    fi

    mkdir -p /workspaces/logs
    : > /workspaces/logs/"${package_directory}".log
    echo "Running in /workspaces/${package_directory}/${module_name}"
    cd /workspaces/"${package_directory}"/"${module_name}" || exit 1
    make NAVISERVER="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    make NAVISERVER="${PREFIX}" install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

    build_cleanup


<a id="builds-ns-modules-build-nsconf-sh"></a>

## builds/ns-modules-build-nsconf.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

    package_directory="naviserver-${NS_MODULES_VERSION}-modules"
      if [ ! -d /workspaces/"${package_directory}" ]; then
          cd /workspaces && sh /builds/ns-modules-download.sh
          tar zxvf naviserver-"${NS_MODULES_VERSION}"-modules.tar.gz --transform s/modules/naviserver-"${NS_MODULES_VERSION}"-modules/
      fi

      mkdir -p /workspaces/logs
      : > /workspaces/logs/"${package_directory}".log
      echo "Running in /workspaces/${package_directory}/nsconf"
      cd /workspaces/"${package_directory}"/nsconf || exit 1
      make NAVISERVER="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
      make NAVISERVER="${PREFIX}" install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

      build_cleanup


<a id="builds-tcl-build-sh"></a>

## builds/tcl-build.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

    package_directory="tcl${TCL_VERSION}"
    if [ ! -d /workspaces/"${package_directory}" ]; then
        cd /workspaces && sh /builds/tcl-download.sh
        tar xfz "${package_directory}"-src.tar.gz
    fi

    if [ ! -f /workspaces/tcl/minizip ]; then
        # tcl8.7 assumes minizip in ../minizip, will cleanup when tcl8.7 releases
        cp /usr/bin/minizip /workspaces/"${package_directory}"/unix
    fi

    mkdir -p /workspaces/logs
    : > /workspaces/logs/"${package_directory}".log
    echo "Running the autoconf configure in /workspaces/tcl/unix"
    cd /workspaces/"${package_directory}"/unix || exit 1
    ./configure --enable-threads --prefix="${PREFIX}" 2>&1 | tee -a
    /workspaces/logs/"${package_directory}".log
    make 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    make install

    # Make sure, we have a tclsh in ns/bin
    if [ -f "${PREFIX}"/bin/tclsh ] ; then
        rm "${PREFIX}"/bin/tclsh
    fi

    ln -sf "${PREFIX}"/bin/tclsh"${TCL_VERSION%.*}" "${PREFIX}"/bin/tclsh

    build_cleanup


<a id="builds-tcl-download-sh"></a>

## builds/tcl-download.sh     :code:

    if [ ! -f tcl"${TCL_VERSION}"-src.tar.gz ] ; then
        echo wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/tcl"${TCL_VERSION}"-src.tar.gz
        wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/tcl"${TCL_VERSION}"-src.tar.gz
    fi


<a id="builds-tcllib-build-sh"></a>

## builds/tcllib-build.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

    package_directory="tcllib-${TCLLIB_VERSION}"
    if [ ! -d /workspaces/"${package_directory}" ]; then
        cd /workspaces && sh /builds/tcllib-download.sh
        tar xvfj tcllib-"${TCLLIB_VERSION}".tar.bz2
    fi

    mkdir -p /workspaces/logs
    echo "Running the autoconf configure in /workspaces/${package_directory}"
    cd /workspaces/"${package_directory}" || exit1
    echo "Building tcllib"
    : > /workspaces/logs/"${package_directory}".log
    ./configure --prefix="${PREFIX}" 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    # cut down on the output to stdout to make Travis-CI consoles faster
    make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log | cut -c1-64

    build_cleanup


<a id="builds-tcllib-download-sh"></a>

## builds/tcllib-download.sh     :code:

    if [ ! -f tcllib-"${TCLLIB_VERSION}".tar.bz2 ] ; then
        wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcllib/tcllib-"${TCLLIB_VERSION}".tar.bz2
    fi


<a id="builds-thread-build-sh"></a>

## builds/thread-build.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

    package_directory="thread${THREAD_VERSION}"
    if [ ! -d /workspaces/"${package_directory}" ]; then
        cd /workspaces && sh /builds/thread-download.sh
        tar xvfz "thread${THREAD_VERSION}".tar.gz
    fi

    mkdir -p /workspaces/logs
    echo "Running the autoconf configure in /workspaces/${package_directory}"
    cd /workspaces/"${package_directory}"/unix/ || exit1
    echo "Building thread"
    : > /workspaces/logs/"${package_directory}".log
    ../configure --enable-threads --prefix="${PREFIX}" --exec-prefix="${PREFIX}" --with-naviserver="${PREFIX}" --with-tcl="${PREFIX}"/lib 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    # cut down on the output to stdout to make Travis-CI consoles faster
    make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log | cut -c1-64

    build_cleanup


<a id="builds-thread-download-sh"></a>

## builds/thread-download.sh     :code:

    if [ ! -f "thread${THREAD_VERSION}".tar.gz ] ; then
        wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/"thread${THREAD_VERSION}".tar.gz
    fi


<a id="builds-tdom-build-sh"></a>

## builds/tdom-build.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

      package_directory=tdom-"${TDOM_VERSION}"

      if [ ! -d /workspaces/"${package_directory}" ]; then
          cd /workspaces && sh /builds/tdom-download.sh
          tar xvfz tdom-"${TDOM_VERSION}"-src.tgz
      fi

      mkdir -p /workspaces/logs
      echo "Running the autoconf configure in /workspaces/${package_directory}"
      cd /workspaces/"${package_directory}"/unix || exit 1
      echo "Building ${package_directory}"
      : > /workspaces/logs/"${package_directory}".log
      ../configure --enable-threads --disable-tdomalloc \
                  --prefix="${PREFIX}" \
                  --exec-prefix="${PREFIX}" \
                  --with-tcl="${PREFIX}"/lib  2>&1 | tee -a /workspaces/logs/"${package_directory}".log
      # cut down on the output to stdout to make Travis-CI consoles faster
      make
      make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log | cut -c1-64

      build_cleanup


<a id="builds-tdom-download-sh"></a>

## builds/tdom-download.sh     :code:

    if [ ! -f tdom-"${TDOM_VERSION}"-src.tgz ] ; then
        echo wget "${WGET_OPTIONS}" http://tdom.org/downloads/tdom-"${TDOM_VERSION}"-src.tgz
        wget "${WGET_OPTIONS}" http://tdom.org/downloads/tdom-"${TDOM_VERSION}"-src.tgz
    fi


<a id="builds-xotcl-build-sh"></a>

## builds/xotcl-build.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

    package_directory="nsf${XOTCL_VERSION}"
    if [ ! -d /workspaces/"nsf${XOTCL_VERSION}" ]; then
        cd /workspaces && sh /builds/xotcl-download.sh
        tar xvfz "nsf${XOTCL_VERSION}".tar.gz
    fi

    mkdir -p /workspaces/logs
    cd /workspaces/"${package_directory}" || exit 1
    echo "Running the autoconf configure in /workspaces/${package_directory}"
    echo "Building nsf${XOTCL_VERSION}"
    : > /workspaces/logs/"${package_directory}".log
    ./configure --enable-threads --enable-symbols \
                --prefix="${PREFIX}" --exec-prefix="${PREFIX}" \
                --with-tcl="${PREFIX}"/lib 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    # cut down on the output to stdout to make Travis-CI consoles faster
    make
    make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

    build_cleanup


<a id="builds-xotcl-download-sh"></a>

## builds/xotcl-download.sh     :code:

    if [ ! -f nsf"${XOTCL_VERSION}".tar.gz ] ; then
        echo wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/next-scripting/nsf"${XOTCL_VERSION}".tar.gz
        wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/next-scripting/nsf"${XOTCL_VERSION}".tar.gz
    fi


<a id="builds-rl-json-build-sh"></a>

## builds/rl\_json-build.sh     :code:

    # shellcheck source=../src/builds/common.sh
    . /builds/common.sh
    # shellcheck source=../src/builds/env-vars.sh
    . /builds/env-vars.sh

    build_setup

    package_directory=rl_json-"${RL_JSON_VERSION}"

    if [ ! -d /workspaces/"${package_directory}" ]; then
        cd /workspaces && sh /builds/rl_json-download.sh
        tar xvfz "${package_directory}".tar.gz
    fi

    mkdir -p /workspaces/logs
    cd /workspaces/"${package_directory}" || exit 1
    echo "Running the autoconf configure in /workspaces/${package_directory}"
    echo "Building ${package_directory}"
    : > /workspaces/logs/"${package_directory}".log
    ./configure --prefix="${PREFIX}" \
         --with-tcl="${PREFIX}"/lib \
         --with-tclinclude="${PREFIX}"/include 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
    # cut down on the output to stdout to make Travis-CI consoles faster
    make
    make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

    build_cleanup


<a id="builds-rl-json-download-sh"></a>

## builds/rl\_json-download.sh     :code:

    if [ ! -f rl_json$-"{RL_JSON_VERSION}".tar.gz ] ; then
        echo "${WGET_OPTIONS}" https://github.com/RubyLane/rl_json/archive/refs/tags/"${RL_JSON_VERSION}".tar.gz
        wget "${WGET_OPTIONS}" https://github.com/RubyLane/rl_json/archive/refs/tags/"${RL_JSON_VERSION}".tar.gz -O rl_json-"${RL_JSON_VERSION}".tar.gz
    fi
