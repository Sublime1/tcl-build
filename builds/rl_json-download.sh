#!/bin/bash
if [ ! -f rl_json$-{rl_json_version}.tar.gz ] ; then
    echo ${wget_options} https://github.com/RubyLane/rl_json/archive/refs/tags/${rl_json_version}.tar.gz
    wget ${wget_options} https://github.com/RubyLane/rl_json/archive/refs/tags/${rl_json_version}.tar.gz -O rl_json-${rl_json_version}.tar.gz
fi
