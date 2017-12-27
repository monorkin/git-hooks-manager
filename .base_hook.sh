#!/usr/bin/env bash

# This file is part of git-hooks-manager.
#
# git-hooks-manager is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# git-hooks-manager is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with git-hooks-manager.  If not, see <http://www.gnu.org/licenses/>

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
  sh "$GLOBAL_HOOKS_DIR/$file" $@
  EXIT_CODES="$EXIT_CODES | $?"
done

for file in $LOCAL_HOOKS
do
  sh "$LOCAL_HOOKS_DIR/$file" $@
  EXIT_CODES="$EXIT_CODES | $?"
done

EXIT_CODE="$(sh -c "! (($EXIT_CODES))")"
exit $EXIT_CODE
