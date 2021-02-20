# Table of Contents

-   [About](#org5f5b65e)
-   [Installation](#org0108893)
    -   [Download from dockerhub](#org55b8d9b)
    -   [Build from chiselapp (fossil)](#org58efbcd)
    -   [Build from github](#orgf77de22)
-   [Configuration options](#org101e0b8)
    -   [General options](#org18f7a4f)
    -   [Timezone](#orga916811)
-   [Usage](#orgcb62ff8)
-   [CI/CD](#org0faa801)
-   [Maintenance](#orgbd32b2f)
    -   [Log output](#orgb909fda)
    -   [Shell access](#org8dc6f67)



<a id="org5f5b65e"></a>

# About

This is [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay) for buid tcl software.

Tcl-build is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/tcl-build>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting tcl-build repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about tcl-build, visit the official self-hosting site linked above.


<a id="org0108893"></a>

# Installation


<a id="org55b8d9b"></a>

## Download from dockerhub

    docker pull oupfiz5/tcl-build:latest
    docker pull oupfiz5/tcl-build:20.04


<a id="org58efbcd"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/tcl-build tcl-build.fossil
    mkdir tcl-build
    cd tcl-build
    fossil open tcl-build/tcl-build.fossil
    docker build -t oupfiz5/tcl-build .


<a id="orgf77de22"></a>

## Build from github

    git clone https://github.com/oupfiz5/tcl-build.git
    cd tcl-build
    docker build -t oupfiz5/tcl-build .


<a id="org101e0b8"></a>

# Configuration options


<a id="org18f7a4f"></a>

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


<a id="orga916811"></a>

## Timezone

Set the timezone for the container, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    docker run -it --rm \
               --name tcl-build  \
               --env 'TZ=Europe/Moscow' \
               oupfiz5/tcl-build:latest \
               /bin/bash


<a id="orgcb62ff8"></a>

# Usage

Run the build container in the background with Docker:

    mkdir -p $PWD/workspaces
    docker run -itd \
        -v $PWD/workspaces:/workspaces\
        -v $PWD/builds:/builds \
        --name=tcl-build \
        oupfiz5/tcl-build:latest

Build everything in tcl-build using a docker exec:

    docker exec -it tcl-build bash /builds/ns-all-build.sh


<a id="org0faa801"></a>

# CI/CD

For  build and push docker images we use  [Github Actions workflow](https://github.com/oupfiz5/build-tcl/blob/master/.github/workflows/on-push.yaml).


<a id="orgbd32b2f"></a>

# Maintenance


<a id="orgb909fda"></a>

## Log output

For debugging and maintenance purposes you may want access the output log. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker interactive:

    docker run -it --rm \
           --name=tcl-build \
           oupfiz5/tcl-build:latest \
           /bin/bash


<a id="org8dc6f67"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are usingDocker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it tcl-build /bin/bash
