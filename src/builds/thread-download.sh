#!/bin/bash
  if [ ! -f "thread${THREAD_VERSION}".tar.gz ] ; then
      wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/tcl/"thread${THREAD_VERSION}".tar.gz
  fi
