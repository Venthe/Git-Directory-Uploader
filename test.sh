#!/usr/bin/env bash

. ./common.sh

TEMP_DIRECTORY="$(mktemp --directory)"
add_on_exit rm --recursive --force "${TEMP_DIRECTORY}"
echo "Creating empty directory: ${TEMP_DIRECTORY}"

TEST_FILE="$(mktemp --tmpdir=${TEMP_DIRECTORY})"
echo "Creating test file: ${TEST_FILE}"

DEBUG=0 \
GIT_USERNAME="Jacek Lipiec" \
GIT_EMAIL="jacek.lipiec.bc@gmail.com" \
WORKDIR="${TEMP_DIRECTORY}" \
./entrypoint.sh