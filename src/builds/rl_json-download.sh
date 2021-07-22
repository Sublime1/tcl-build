#!/bin/bash
if [ ! -f rl_json$-"{RL_JSON_VERSION}".tar.gz ] ; then
    echo "${WGET_OPTIONS}" https://github.com/RubyLane/rl_json/archive/refs/tags/"${RL_JSON_VERSION}".tar.gz
    wget "${WGET_OPTIONS}" https://github.com/RubyLane/rl_json/archive/refs/tags/"${RL_JSON_VERSION}".tar.gz -O rl_json-"${RL_JSON_VERSION}".tar.gz
fi
