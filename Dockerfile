# * Base image
#  FROM ubuntu:20.04
FROM oupfiz5/ubuntu-s6:latest

# * Arguments
ARG BUILD_DATE
ARG FOSSIL_VERSION=2.14

# * Labels
LABEL \
    maintainer="Oupfiz V <oupfiz5@yandex.ru>" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.authors="Oupfiz V (Five)" \
    org.opencontainers.image.url="https://chiselapp.com/user/oupfiz5/repository/tcl-build/home" \
    org.opencontainers.image.documentation="https://chiselapp.com/user/oupfiz5/repository/tcl-build/wiki" \
    org.opencontainers.image.source="https://chiselapp.com/user/oupfiz5/repository/tcl-build/brlist" \
    org.opencontainers.image.version="0.0.1d" \
    org.opencontainers.image.revision="" \
    org.opencontainers.image.vendor="" \
    org.opencontainers.image.licenses="" \
    org.opencontainers.image.ref.name="" \
    org.opencontainers.image.title="Ubuntu image for build tcl packages" \
    org.opencontainers.image.description="Ubuntu image for build tcl packages"

# * Environment

# * Copy
COPY rootfs/ /

# * Add
ADD https://www.fossil-scm.org/home/uv/fossil-linux-x64-${FOSSIL_VERSION}.tar.gz /tmp/fossil-linux.tar.gz

# * Run
# RUN export LANG="en_US.UTF-8" && export LC_ALL="en_US.UTF-8"
RUN export LANG="en_US.UTF-8" && export LC_ALL="en_US.UTF-8" \
    &&  apt-get update \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install curl wget gnupg apt-utils tzdata bash git \
    && apt-get -y install automake autoconf make gcc locales \
    && apt-get -y install zlib1g-dev libreadline-dev libtool minizip openssl libssl-dev libpq-dev postgresql-client \
    && apt-get -y install python3-pip python3-venv libzookeeper-mt-dev libboost-all-dev libuv1-dev swig3.0 libyajl-dev \
    && apt-get -y install libgd-dev pkg-config gdb libcurl4-openssl-dev \
    && apt-get -y install libmemcached-dev libxml2-dev libxslt-dev apache2-dev apache2 \
    && apt-get -y install libgeos-dev libproj-dev libbsd-dev lsb-release \
    && pip3 install "cmake==3.17.2" \
    && locale-gen en_US.UTF-8 \
    && update-locale LANG="en_US.UTF-8" \
    && update-locale LC_ALL="en_US.UTF-8" \
    && cd /tmp \
    && tar xzf /tmp/fossil-linux.tar.gz -C /usr/bin \
    && rm /tmp/fossil-linux.tar.gz \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/cache/apt/*

# * Command
# CMD ["sleep", "366d"]

# * Entrypoint
ENTRYPOINT ["/init"]
