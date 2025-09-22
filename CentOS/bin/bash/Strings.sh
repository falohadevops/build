#!/usr/bin/env bash

# @param string $1
#   Input string.
# @param int $2
#   Cut an amount of characters from left side of string.
# @param int [$3]
#   Leave an amount of characters in the truncated string.
substr()
{
    local length=${3}

    if [ -z "${length}" ]; then
        length=$((${#1} - ${2}))
    fi

    local str=${1:${2}:${length}}

    if [ "${#str}" -eq "${#1}" ]; then
        echo "${1}"
    else
        echo "${str}"
    fi
}
# @param string $1
#   Input string.
# @param string $2
#   String that will be searched in input string.
# @param int [$3]
#   Offset of an input string.
strpos()
{
    local str=${1}
    local offset=${3}

    if [ -n "${offset}" ]; then
        str=`substr "${str}" ${offset}`
    else
        offset=0
    fi

    str=${str/${2}*/}

    if [ "${#str}" -eq "${#1}" ]; then
        return 0
    fi

    echo $((${#str}+${offset}))
}
