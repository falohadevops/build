#!/bin/bash
# 
# Installs to /root
CURDIR=`pwd`
if [ "$CURDIR" != "/root/build/CentOS" ]; then
  echo "Bad location. You need to be in /root/build/CentOS"
  exit
fi
#
mkdir -p /root/bin
mkdir -p /root/config
cp -r bin /root
cp -r etc /root/config
cp -r home /root/config
#