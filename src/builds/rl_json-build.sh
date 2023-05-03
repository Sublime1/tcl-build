#!/bin/bash
# shellcheck source=../src/builds/common.sh
. /builds/common.sh
# shellcheck source=../src/builds/env-vars.sh
. /builds/env-vars.sh
# shellcheck disable=SC1091
. /VERSIONS

build_setup

# * Get from git repository
package_directory="rl_json-${RL_JSON_VERSION}"
repo='https://github.com/RubyLane/rl_json.git'
extra="--recurse-submodules --shallow-submodules --depth 1 --branch ${RL_JSON_VERSION}"

# shellcheck disable=SC2086
build_git_clone $package_directory $repo $extra

# Because https://github.com/RubyLane/rl_json/issues/41#
#if [ ! -d /workspaces/"${package_directory}" ]; then
#    cd /workspaces && sh /builds/rl_json-download.sh
#    tar xvfz "${package_directory}".tar.gz
#fi

mkdir -p /workspaces/logs
cd /workspaces/"${package_directory}" || exit 1
echo "Running the autoconf configure in /workspaces/${package_directory}"
autoconf || exit 1
ls -la config*
echo "Building ${package_directory}"
: > /workspaces/logs/"${package_directory}".log
./configure --prefix="${PREFIX}" \
    --with-tcl="${PREFIX}"/lib \
    --with-tclinclude="${PREFIX}"/include 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
# cut down on the output to stdout to make Travis-CI consoles faster
make
make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

build_cleanup
