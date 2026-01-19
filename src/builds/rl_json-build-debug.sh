#!/bin/bash
# Enable debugging - set -x prints each command before execution
# set -e exits on first error, set -u exits on undefined variables
set -eu

# Uncomment the next line for verbose command tracing
# set -x

# ========================================
# DEBUG LOGGING SETUP
# All output will be saved to this file, which persists after Docker build
# ========================================
DEBUG_LOG="/usr/local/ns/logs/rl_json-debug-$(date +%Y%m%d-%H%M%S).log"
mkdir -p /usr/local/ns/logs

# Log function - use this instead of echo for important debug messages
log() {
    echo "$*" | tee -a "${DEBUG_LOG}"
}

# Ensure log is written even if script fails
trap 'echo "DEBUG: Script exited with code $?. Full log saved to: ${DEBUG_LOG}" | tee -a "${DEBUG_LOG}"; sync' EXIT

# shellcheck source=../src/builds/common.sh
. /builds/common.sh
# shellcheck source=../src/builds/env-vars.sh
. /builds/env-vars.sh
# shellcheck disable=SC1091
. /VERSIONS

log "========================================"
log "DEBUG: Starting rl_json build script"
log "DEBUG: Date: $(date)"
log "DEBUG: Log file: ${DEBUG_LOG}"
log "========================================"

build_setup

# * Get from git repository
package_directory="rl_json-${RL_JSON_VERSION}"
repo='https://github.com/RubyLane/rl_json.git'
extra="--recurse-submodules --shallow-submodules --depth 1 --branch ${RL_JSON_VERSION}"

log "DEBUG: Environment variables:"
log "  RL_JSON_VERSION=${RL_JSON_VERSION:-NOT SET}"
log "  PREFIX=${PREFIX:-NOT SET}"
log "  package_directory=${package_directory}"
log "  repo=${repo}"
log "  extra=${extra}"
log "========================================"

# CRITICAL: Must quote "$extra" to preserve spaces in the parameter string
# Without quotes, "--recurse-submodules --shallow-submodules --depth 1 --branch 0.15.3"
# gets split and only "--recurse-submodules" is passed to the function as $3
build_git_clone "$package_directory" "$repo" "$extra"

# Because https://github.com/RubyLane/rl_json/issues/41#
#if [ ! -d /workspaces/"${package_directory}" ]; then
#    cd /workspaces && sh /builds/rl_json-download.sh
#    tar xvfz "${package_directory}".tar.gz
#fi

mkdir -p /workspaces/logs

log "DEBUG: Checking if package directory exists..."
if [ ! -d "/workspaces/${package_directory}" ]; then
    log "ERROR: Directory /workspaces/${package_directory} does not exist!"
    log "DEBUG: Contents of /workspaces:"
    ls -la /workspaces/ | tee -a "${DEBUG_LOG}"
    exit 1
fi

cd /workspaces/"${package_directory}" || { log "ERROR: Failed to cd to /workspaces/${package_directory}"; exit 1; }

log "DEBUG: Current directory: $(pwd)"
log "DEBUG: *** VERIFYING GIT CLONE ***"
log "DEBUG: Git commit:"
git log -1 --oneline 2>&1 | tee -a "${DEBUG_LOG}" || log "WARNING: git log failed"
log "DEBUG: Git describe:"
git describe --tags 2>&1 | tee -a "${DEBUG_LOG}" || log "WARNING: git describe failed"
log "DEBUG: AC_INIT version from configure.ac:"
grep "^AC_INIT" configure.ac 2>&1 | tee -a "${DEBUG_LOG}" || log "WARNING: grep AC_INIT failed"
log "DEBUG: Checking for deps directory:"
ls -la deps/ 2>&1 | tee -a "${DEBUG_LOG}" || log "DEBUG: No deps/ directory (expected for 0.15.3)"
log "DEBUG: Submodule status:"
git submodule status 2>&1 | tee -a "${DEBUG_LOG}" || log "WARNING: git submodule status failed"
log "DEBUG: *** END GIT VERIFICATION ***"

log "DEBUG: Directory contents:"
ls -la | tee -a "${DEBUG_LOG}"

log "DEBUG: Checking for configure.ac or configure.in..."
if [ -f "configure.ac" ]; then
    log "DEBUG: Found configure.ac"
elif [ -f "configure.in" ]; then
    log "DEBUG: Found configure.in"
else
    log "WARNING: No configure.ac or configure.in found!"
fi

log "Running the autoconf configure in /workspaces/${package_directory}"
if ! autoconf 2>&1 | tee -a "${DEBUG_LOG}"; then
    log "ERROR: autoconf failed!"
    log "DEBUG: Checking autoconf version:"
    autoconf --version 2>&1 | tee -a "${DEBUG_LOG}" || true
    exit 1
fi

log "DEBUG: autoconf completed successfully"
log "DEBUG: Config files generated:"
ls -la config* 2>/dev/null | tee -a "${DEBUG_LOG}" || log "WARNING: No config* files found"

log "DEBUG: Checking Tcl installation at PREFIX=${PREFIX}..."
log "DEBUG: Contents of ${PREFIX}/lib:"
ls -la "${PREFIX}"/lib/ 2>/dev/null | head -20 | tee -a "${DEBUG_LOG}" || log "WARNING: Cannot list ${PREFIX}/lib"
log "DEBUG: Looking for tclConfig.sh:"
find "${PREFIX}" -name "tclConfig.sh" 2>/dev/null | tee -a "${DEBUG_LOG}" || log "WARNING: tclConfig.sh not found"
log "DEBUG: Contents of ${PREFIX}/include:"
ls -la "${PREFIX}"/include/ 2>/dev/null | head -20 | tee -a "${DEBUG_LOG}" || log "WARNING: Cannot list ${PREFIX}/include"

log "========================================"
log "Building ${package_directory}"
log "========================================"
: > /workspaces/logs/"${package_directory}".log

log "DEBUG: GCC version:"
gcc --version 2>&1 | head -3 | tee -a "${DEBUG_LOG}"
log "DEBUG: Checking if Tcl's tcl.h already defines mp_digit..."
TCL_HAS_TOMMATH=0
if grep -q "typedef.*mp_digit" "${PREFIX}/include/tcl.h" 2>/dev/null; then
    log "DEBUG: Tcl's tcl.h defines mp_digit - will patch rl_json to avoid conflict"
    TCL_HAS_TOMMATH=1
else
    log "DEBUG: Tcl's tcl.h does not define mp_digit - using rl_json's tommath"
fi

log "DEBUG: Running configure..."
if ! ./configure --prefix="${PREFIX}" \
    --with-tcl="${PREFIX}"/lib \
    --with-tclinclude="${PREFIX}"/include 2>&1 | tee -a "${DEBUG_LOG}" | tee -a /workspaces/logs/"${package_directory}".log; then
    log "ERROR: configure failed!"
    log "DEBUG: Last 50 lines of config.log:"
    tail -50 config.log 2>/dev/null | tee -a "${DEBUG_LOG}" || log "WARNING: No config.log found"
    exit 1
fi

log "DEBUG: configure completed successfully"

log "DEBUG: Running make..."

# cut down on the output to stdout to make Travis-CI consoles faster
# Save output to temp file to capture both output and exit code
MAKE_OUTPUT=$(mktemp)
if make 2>&1 | tee "${MAKE_OUTPUT}"; then
    MAKE_EXIT=0
else
    MAKE_EXIT=1
fi
cat "${MAKE_OUTPUT}" >> "${DEBUG_LOG}"
# Check if make actually failed by looking for error in output
if grep -q "^make.*Error" "${MAKE_OUTPUT}" || grep -q "^make\[.*\]: \*\*\*" "${MAKE_OUTPUT}"; then
    log "ERROR: make failed!"
    log "DEBUG: Last 50 lines of make output:"
    tail -50 "${MAKE_OUTPUT}" | tee -a "${DEBUG_LOG}"
    rm -f "${MAKE_OUTPUT}"
    exit 1
fi
rm -f "${MAKE_OUTPUT}"

log "DEBUG: make completed successfully"
log "DEBUG: Running make install..."

MAKE_OUTPUT=$(mktemp)
if make install 2>&1 | tee "${MAKE_OUTPUT}"; then
    MAKE_EXIT=0
else
    MAKE_EXIT=1
fi
cat "${MAKE_OUTPUT}" >> "${DEBUG_LOG}"
if grep -q "^make.*Error" "${MAKE_OUTPUT}" || grep -q "^make\[.*\]: \*\*\*" "${MAKE_OUTPUT}"; then
    log "ERROR: make install failed!"
    rm -f "${MAKE_OUTPUT}"
    exit 1
fi
rm -f "${MAKE_OUTPUT}"

log "DEBUG: make install completed successfully"
log "DEBUG: Verifying installation..."
log "DEBUG: Looking for rl_json in ${PREFIX}:"
find "${PREFIX}" -name "*rl_json*" 2>/dev/null | tee -a "${DEBUG_LOG}" || log "WARNING: No rl_json files found in ${PREFIX}"

log "========================================"
log "DEBUG: rl_json build completed successfully!"
log "========================================"

build_cleanup
