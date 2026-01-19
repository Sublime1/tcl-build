#!/bin/bash
set -euo pipefail

# shellcheck source=../src/builds/common.sh
. /builds/common.sh
# shellcheck source=../src/builds/env-vars.sh
. /builds/env-vars.sh
# shellcheck disable=SC1091
. /VERSIONS

build_setup

package_directory="rl_json-${RL_JSON_VERSION}"
repo='https://github.com/RubyLane/rl_json.git'
# CRITICAL: Must quote "$extra" when passing to build_git_clone to preserve spaces
extra="--recurse-submodules --shallow-submodules --depth 1 --branch ${RL_JSON_VERSION}"

build_git_clone "$package_directory" "$repo" "$extra"

mkdir -p /workspaces/logs
cd /workspaces/"${package_directory}" || exit 1

echo "Building ${package_directory}"
: > /workspaces/logs/"${package_directory}".log

autoconf || { echo "ERROR: autoconf failed"; exit 1; }
./configure --prefix="${PREFIX}" \
    --with-tcl="${PREFIX}"/lib \
    --with-tclinclude="${PREFIX}"/include 2>&1 | tee -a /workspaces/logs/"${package_directory}".log
# cut down on the output to stdout to make Travis-CI consoles faster
make
make install 2>&1 | tee -a /workspaces/logs/"${package_directory}".log

build_cleanup
