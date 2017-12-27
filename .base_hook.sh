#!/usr/bin/env bash

FILE_PATH="$(dirname $0)"
FILE_NAME="$(basename $0)"
HOOK_DIR="$FILE_NAME-hooks"

BASE_DIR="$HOME/.git-templates"

GLOBAL_HOOKS_DIR="$BASE_DIR/.global-hooks/$HOOK_DIR"
LOCAL_HOOKS_DIR="$FILE_PATH/$HOOK_DIR"

LOCAL_HOOKS="$(ls -A $LOCAL_HOOKS_DIR)"
GLOBAL_HOOKS="$(ls -A $GLOBAL_HOOKS_DIR)"

EXIT_CODES="0"

for file in $GLOBAL_HOOKS
do
  sh "$GLOBAL_HOOKS_DIR/$file"
  EXIT_CODES="$EXIT_CODES | $?"
done

for file in $LOCAL_HOOKS
do
  sh "$LOCAL_HOOKS_DIR/$file"
  EXIT_CODES="$EXIT_CODES | $?"
done

EXIT_CODE="$(sh -c "! (($EXIT_CODES))")"
exit $EXIT_CODE
