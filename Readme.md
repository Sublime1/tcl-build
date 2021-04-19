# Table of Contents

-   [About](#org3d315fb)
-   [Installation](#orgd78a7c7)
    -   [Download from dockerhub](#org18c9bf1)
    -   [Build from chiselapp (fossil)](#orgfeff292)
    -   [Build from github](#orgadd3bbf)
    -   [Configuration](#orgc95da74)
        -   [Build arguments](#orgea9149f)
        -   [Example of build](#orgd2f2343)
-   [Configuration options](#org1856e04)
    -   [General options](#org4f97bb2)
    -   [Timezone](#orga4dfa1b)
-   [Applications](#org7e53352)
    -   [Configuration](#org8cd1d18)
-   [Usage](#orgf93b6f0)
    -   [Builder](#orge6bc007)
    -   [Build applications](#org7f3c371)
-   [Prepare source packages](#org7109ad3)
-   [CI/CD](#org4fc94f9)
-   [Maintenance](#org6e79ed6)
    -   [Log output](#orgddf7625)
    -   [Shell access](#org14c3db2)



<a id="org3d315fb"></a>

# About

This is [ubuntu base docker image](https://hub.docker.com/_/ubuntu) (version 20.04) using [s6-overlay](https://github.com/just-containers/s6-overlay) for buid tcl software. The basic idea was taken from [tcl2020-build](https://github.com/tcl2020/tcl2020-build) .

Tcl-build is self-hosting at <https://chiselapp.com/user/oupfiz5/repository/tcl-build>.

If you are reading this on GitHub, then you are looking at a Git mirror of the self-hosting tcl-build repository.  The purpose of that mirror is to test and exercise Fossil's ability to export a Git mirror and using Github CI/CD  (Github Actions). Nobody much uses the GitHub mirror, except to verify that the mirror logic works. If you want to know more about tcl-build, visit the official self-hosting site linked above.


<a id="orgd78a7c7"></a>

# Installation


<a id="org18c9bf1"></a>

## Download from dockerhub

    docker pull oupfiz5/tcl-build:latest
    docker pull oupfiz5/tcl-build:20.04


<a id="orgfeff292"></a>

## Build from chiselapp (fossil)

    fossil clone https://chiselapp.com/user/oupfiz5/repository/tcl-build tcl-build.fossil
    mkdir tcl-build
    cd tcl-build
    fossil open ../tcl-build.fossil
    docker build -t oupfiz5/tcl-build .


<a id="orgadd3bbf"></a>

## Build from github

    git clone https://github.com/oupfiz5/tcl-build.git
    cd tcl-build
    docker build -t oupfiz5/tcl-build .


<a id="orgc95da74"></a>

## Configuration


<a id="orgea9149f"></a>

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


<a id="orgd2f2343"></a>

### Example of build

    docker build \
           --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
           --build-arg VERSION='21.04' \
           --build-arg FOSSIL_VERSION='2.15.1' \
           -t oupfiz5/tcl-build:21.04 \
           -t oupfiz5/tcl-build:latest \
           -f ./Dockerfile \
            .


<a id="org1856e04"></a>

# Configuration options

For configuration is using environment variables.


<a id="org4f97bb2"></a>

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


<a id="orga4dfa1b"></a>

## Timezone

Set the timezone for the container, defaults to UTC. To set the timezone set the desired timezone with the variable TZ.

    mkdir -p $PWD/workspaces
    docker run -itd \
        -v $PWD/workspaces:/workspaces\
        -v $PWD/builds:/builds \
        --env 'TZ=Europe/Moscow' \
        --name=tcl-build \
        oupfiz5/tcl-build:latest


<a id="org7e53352"></a>

# Applications

The docker support builds for  the following applications:

-   tcl
-   tcllib
-   rl\_json
-   NaviServer
-   tDOM
-   xotcl


<a id="org8cd1d18"></a>

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


<a id="orgf93b6f0"></a>

# Usage


<a id="orge6bc007"></a>

## Builder

Run the build container in the background with Docker:

    mkdir -p $PWD/workspaces
    docker run -itd \
        -v $PWD/workspaces:/workspaces\
        -v $PWD/builds:/builds \
        --name=tcl-build \
        oupfiz5/tcl-build:latest


<a id="org7f3c371"></a>

## Build applications

Build all program in tcl-build using a `docker exec` and default congratulations:

    docker exec -it tcl-build bash /builds/all-build.sh

Build any applications with version customization in tcl-build using `docker exec`. For example install tcl version 8.6.10 is:

    docker exec -it \
           -e TCL_VERSION=8.6.10 \
           tcl-build \
           bash /builds/tcl-build.sh

Modify the source code of any package in the workspaces directory. Then you can use make, cmake, &#x2026; to rebuild the container with the changes.  Use the build container with your favorite IDE.


<a id="org7109ad3"></a>

# Prepare source packages

Source packages are added to the Docker image using the `builds/build-all.sh` script.

To add packages or features create a two shell scripts in `builds` directory.  One shell script will download the source package: `yourpackage-download.sh`. The other script will build the package: `yourpackage-build.sh`.  Add your new build script, `yourpackage-build.sh`, to `builds/all-build.sh`.


<a id="org4fc94f9"></a>

# CI/CD

For  build and push docker images using  [Github Actions workflow](https://github.com/oupfiz5/build-tcl/blob/master/.github/workflows/on-push.yaml).


<a id="org6e79ed6"></a>

# Maintenance


<a id="orgddf7625"></a>

## Log output

For debugging and maintenance purposes you may want access the output log. If you are using Docker version 1.3.0 or higher you can access a running containers shell by starting bash using docker interactive:

    docker run -it --rm \
           --name=tcl-build \
           oupfiz5/tcl-build:latest \
           /bin/bash


<a id="org14c3db2"></a>

## Shell access

For debugging and maintenance purposes you may want access the containers shell. If you are usingDocker version 1.3.0 or higher you can access a running containers shell by starting bash using docker exec:

    docker exec -it tcl-build /bin/bash
