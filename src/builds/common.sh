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
        echo "pwd=$(pwd)"
        echo "Name=${name}"
        echo "Repo=${repo}"
        echo "Extra=${extra}"
        echo "Command is: git clone ${extra} ${repo} ${name}"
        # shellcheck disable=SC2086
        git clone ${extra} ${repo} ${name}
    fi
}


build_cleanup () {
    # fix any permissions messed up by the Docker user id
    # allow edits to the source outside of the container
    find "$(readlink -f /workspaces)" -type d -print0 | xargs -0 chmod go+rwx
    find "$(readlink -f /workspaces)" -type f -print0 | xargs -0 chmod go+rw
}
