#!/usr/bin/env bash

FILE_NAME="$(basename $0)"
HOOK_DIR="$FILE_NAME-hooks"
BASE_DIR="$HOME/.git-templates"
BASE_HOOKS_DIR="$BASE_DIR/hooks"
HOOKS_DIR="$BASE_HOOKS_DIR/$HOOK_DIR"
HOOKS="$(ls -A $HOOKS_DIR)"

for file in $HOOKS
do
  sh "$HOOKS_DIR/$file"
done
