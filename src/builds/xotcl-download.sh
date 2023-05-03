#!/bin/bash
  if [ ! -f nsf"${XOTCL_VERSION}".tar.gz ] ; then
      echo wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/next-scripting/nsf"${XOTCL_VERSION}".tar.gz
      wget "${WGET_OPTIONS}" https://downloads.sourceforge.net/sourceforge/next-scripting/nsf"${XOTCL_VERSION}".tar.gz
  fi
