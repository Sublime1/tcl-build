#!/bin/bash
export PREFIX="${PREFIX:-/usr}"

# * Versions
# export NS_VERSION="${NS_VERSION:-4.99.22}"
# export NS_MODULES_VERSION="${NS_MODULES_VERSION:-4.99.22}"
# export RL_JSON_VERSION="${RL_JSON_VERSION:-0.11.1}"
# export TDOM_VERSION="${TDOM_VERSION:-0.9.1}"
# export THREAD_VERSION="${THREAD_VERSION:-2.8.6}"
# export TCL_VERSION="${TCL_VERSION:-8.6.11}"
# export TCLLIB_VERSION="${TCLLIB_VERSION:-1.20}"
# export XOTCL_VERSION="${XOTCL_VERSION:-2.3.0}"

# * Options
export WGET_OPTIONS="${WGET_OPTIONS:- --retry-connrefused --waitretry=1 --read-timeout=20 --timeout=15 -t 10 }"

# * NaviServer
# Using for NaviServer
# the pg_* variables should be the path leading to the include and
# library file of postgres to be used in this build.  In particular,
# "libpq-fe.h" and "libpq.so" are typically needed.
export PG_INCL="/usr/include/postgresql"
export PG_LIB="/usr/lib"
