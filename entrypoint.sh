#!/usr/bin/env bash

set -e

WORKDIR="${WORKDIR:-/workdir}"

. ./common.sh

cd "${WORKDIR}"

if [ -z "${GIT_USERNAME}" ]; then
    >&2 echo "Username is not provided"
    exit 1
fi

if [ -z "${GIT_EMAIL}" ]; then
    >&2 echo "Email is not provided"
    exit 1
fi

IS_GIT=$(git rev-parse --is-inside-work-tree 2>&1 > /dev/null) || "false"
if [ $IS_GIT == "true" ]; then
    >&2 echo "Repository is already created cannot automatically handle this situation"
    exit 1
fi

TEMP_DIRECTORY="$(mktemp --directory)"
echo "Creating empty directory: ${TEMP_DIRECTORY}"
add_on_exit rm --recursive --force "${TEMP_DIRECTORY}"

cp -r ./* "${TEMP_DIRECTORY}"
cd $TEMP_DIRECTORY
git init
git commit -m 'Initial commit' --allow-empty
git add --all
git commit -m "Add initial files"