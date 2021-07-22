#!.bats-battery/bats-core/bin/bats
load './helpers.bash'

setup() {
    . ./common_conf.bash
    WORKSPACES="${BATS_TMPDIR}"/workspaces
}

@test "Remove container" {
    run docker container rm "${CONTAINER_NAME}" || true
    assert_success
}

@test "Run tcl-build container" {
    mkdir -p "${WORKSPACES}"
    # echo "${WORKSPACES}" >&3
    run docker run -itd \
           -v ${WORKSPACES}:/workspaces \
           -v $(pwd)/../src/builds:/builds \
           --name="${CONTAINER_NAME}" \
           "${IMAGE}"
    assert_success
}

@test "Build all" {
    run docker exec -it \
        "${CONTAINER_NAME}" \
        bash /builds/all-build.sh
    assert_success
}

@test "Container stop" {
    run docker container stop "${CONTAINER_NAME}"
    assert_success
}

@test "Container remove" {
    run docker container rm "${CONTAINER_NAME}"
    assert_success
}

@test "Remove temporary directory (workspaces)" {
    run rm -rf "${WORKSPACES}"
    assert_success
}
