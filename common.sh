#!/usr/bin/env bash

DEBUG="${DEBUG:-0}"
if [ $DEBUG -eq 1 ]; then
    set -x
fi

set -o errexit
set -o pipefail
set -u

function_exists() {
    declare -f -F $1 > /dev/null
    return $?
}

function_exists add_on_exit || echo "Library already loaded" && exit 0

>&2 echo "Loading common script library"

declare -a on_exit_items

function on_exit()
{
    for i in "${on_exit_items[@]}"
    do
        >&2 echo "on_exit: $i"
        eval $i
    done
}

function add_on_exit()
{
    local n=${#on_exit_items[*]}
    on_exit_items[$n]="$*"
    if [[ $n -eq 0 ]]; then
        >&2 echo "Setting trap: ${*}"
        trap on_exit EXIT
    fi
}

set +u
