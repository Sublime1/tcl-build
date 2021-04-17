#!/bin/bash
export prefix="${prefix:-/usr}"

# * Versions
export ns_version="${ns_version:-4.99.21}"
export ns_modules_version="${ns_modules_version:-4.99.21}"
export rl_json_version="${rl_json_version:-0.11.0}"
export tdom_version="${tdom_version:-0.9.1}"
export tcl_version="${tcl_version:-8.6.11}"
export tcllib_version="${tcllib_version:-1.20}"
export xotcl_version="${xotcl_version:-2.3.0}"

# * Options
export wget_options="${wget_options:-""}"

# * NaviServer
# Using for NaviServer
# the pg_* variables should be the path leading to the include and
# library file of postgres to be used in this build.  In particular,
# "libpq-fe.h" and "libpq.so" are typically needed.
export pg_incl="/usr/include/postgresql"
export pg_lib="/usr/lib"
