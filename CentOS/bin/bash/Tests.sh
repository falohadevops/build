#!/usr/bin/env bash

# Load Bash Utility Libraries
. ./Hash.sh
. ./Strings.sh

declare -A hosts
declare -a addrs
declare -a keys

  hosts["h01"]="10.0.0.1" # comment
  hosts["h02"]="10.0.0.2"
  hosts["h03"]="10.0.0.3"
  hosts["h04"]="10.0.0.4"

  keys+=(`hostname`)
  keys+=("h03")

  except_values hosts keys addrs
  declare -p hosts
  declare -p addrs
  declare -p keys

 echo ${keys[@]}
  for addr in ${addrs[@]}
  do
    echo $addr
  done

  exit 3
