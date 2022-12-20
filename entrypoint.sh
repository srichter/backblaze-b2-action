#!/bin/sh

set -e

if [ -z "$B2_BUCKET" ]; then
  echo "B2_BUCKET is not set. Quitting."
  exit 1
fi

if [ -z "$B2_APPKEY_ID" ]; then
  echo "B2_APPKEY_ID is not set. Quitting."
  exit 1
fi

if [ -z "$B2_APPKEY" ]; then
  echo "B2_APPKEY is not set. Quitting."
  exit 1
fi

if [ -z "$SOURCE_DIR" ]; then
  echo "SOURCE_DIR is not set. Quitting."
  exit 1
fi

EXCLUDE=""
if [ -n "$EXCLUDE_LIST" ]; then
  EXCLUDE="--excludeRegex '$EXCLUDE_LIST'"
fi

b2 authorize-account ${B2_APPKEY_ID} ${B2_APPKEY}

b2 sync ${EXCLUDE} ${SOURCE_DIR} ${B2_BUCKET}

b2 clear-account
