#!/usr/bin/env bash

# is value in the array
is_in_array() {
  local inarray="$1[@]"
  local seeking=$2
  local found=0
    for element in "${!inarray}"; do
      if [[ $element == "$seeking" ]]; then
        found=1
        break
      fi
    done
    [ $found == 1 ]
}

# @param Array $1 - Associate Array: declare -A array
# @param array $2 - keys to not include their values in return array
# @param array $3 - return array
except_values() {
  local -n inarray=$1
  local -n exceptkeys=$2
  local -n retarray=$3

  for i in "${!inarray[@]}"
  do
    key=${inarray[$i]}
    if ! is_in_array exceptkeys $i
    then
      retarray+=(${inarray[$i]})
    fi
  done
}
# @param Array $1 - Associate Array: declare -A array
# @param array $2 - keys to include their values in return array
# @param array $3 - return array
just_values() {
  local -n inarray=$1
  local -n exceptkeys=$1
}
