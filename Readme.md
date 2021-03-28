# Table of Contents

-   [About](#orgdccc278)
-   [Installation](#org0008804)
    -   [Download from dockerhub](#org65dc92a)
    -   [Build from chiselapp (fossil)](#orgd1e8782)
    -   [Build from github](#orga5ef776)
-   [Configuration options](#orgb9e7734)
    -   [General options](#orgccb9f5f)
    -   [Timezone](#orgac247bc)
-   [Usage](#org63463be)
-   [Prepare source packages](#org148fab1)
-   [CI/CD](#orgba53687)
-   [Maintenance](#org3b7f4a7)
    -   [Log output](#org298ac72)
    -   [Shell access](#org432c10a)



<a id="orgdccc278"></a>

# About

This is [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay) for buid tcl software. The basic idea was taken from [tcl2020-build](https://github.com/tcl2020/tcl2020-build) .

Tcl-build is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/tcl-build>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting tcl-build repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about tcl-build, visit the official self-hosting site linked above.


<a id="org0008804"></a>

# Installation


<a id="org65dc92a"></a>

## Download from dockerhub

    docker pull oupfiz5/tcl-build:latest
    docker pull oupfiz5/tcl-build:20.04


<a id="orgd1e8782"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/tcl-build tcl-build.fossil
    mkdir tcl-build
    cd tcl-build
    fossil open ../tcl-build.fossil
    docker build -t oupfiz5/tcl-build .


<a id="orga5ef776"></a>

## Build from github

    git clone https://github.com/oupfiz5/tcl-build.git
    cd tcl-build
    docker build -t oupfiz5/tcl-build .


<a id="orgb9e7734"></a>

# Configuration options


<a id="orgccb9f5f"></a>

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


<a id="orgac247bc"></a>

## Timezone

Set the timezone for the container, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    docker run -it --rm \
               --name tcl-build  \
               --env 'TZ=Europe/Moscow' \
               oupfiz5/tcl-build:latest \
               /bin/bash


<a id="org63463be"></a>

# Usage

Run the build container in the background with Docker:

    mkdir -p $PWD/workspaces
    docker run -itd \
        -v $PWD/workspaces:/workspaces\
        -v $PWD/builds:/builds \
        --name=tcl-build \
        oupfiz5/tcl-build:latest

Build Naviserver in tcl-build using a docker exec:

    docker exec -it tcl-build bash /builds/ns-all-build.sh

Modify the source code of any package in the workspaces directory. Then you can use make, cmake, &#x2026; to rebuild the container with the changes.  Use the build container with your favorite IDE


<a id="org148fab1"></a>

# Prepare source packages

Source packages are added to the Docker image using the `builds/build-all.sh` script.

To add packages or features create a two shell scripts in `builds` directory.  One shell script will download the source package: `yourpackage-download.sh`. The other script will build the package: `yourpackage-build.sh`.  Add your new build script, `yourpackage-build.sh`, to `builds/all-build.sh`.


<a id="orgba53687"></a>

# CI/CD

For  build and push docker images using  [Github Actions workflow](https://github.com/oupfiz5/build-tcl/blob/master/.github/workflows/on-push.yaml).


<a id="org3b7f4a7"></a>

# Maintenance


<a id="org298ac72"></a>

## Log output

For debugging and maintenance purposes you may want access the output log. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker interactive:

    docker run -it --rm \
           --name=tcl-build \
           oupfiz5/tcl-build:latest \
           /bin/bash


<a id="org432c10a"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are usingDocker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it tcl-build /bin/bash
