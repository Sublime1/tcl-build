#!/bin/bash
export ns_install_dir="/usr/local/ns"
export ns_version="4.99.21"
export ns_modules_version="${ns_version}"
export tdom_version="0.9.1"
export tcl_version="8.6.11"
export tcllib_version="1.20"
export wget_options=""
export xotcl_version="2.3.0"

# the pg_* variables should be the path leading to the include and
# library file of postgres to be used in this build.  In particular,
# "libpq-fe.h" and "libpq.so" are typically needed.
export pg_incl="/usr/include/postgresql"
export pg_lib="/usr/lib"
