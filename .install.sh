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

REMOTE="git@github.com:stankec/git-hooks-manager.git"
INSTALL_DIR="$HOME/.git-templates"
HOOKS="applypatch-msg commit-msg post-update pre-applypatch pre-commit pre-push pre-rebase pre-receive prepare-commit-msg update"
BASE_HOOK_PATH=$INSTALL_DIR/.base_hook.sh
GITCONFIG_PATH=$HOME/.gitconfig

# Clone repo and move into it
if [ ! -d "$INSTALL_DIR" ]; then
  echo "Couldn't find '$INSTALL_DIR'..."
  echo "Pulling from remote..."
  git clone -q $REMOTE $INSTALL_DIR
fi


if [ -d "$INSTALL_DIR" ]; then
  echo "Moving to install direcory..."
  cd $INSTALL_DIR
else
  echo "ERROR: Couldn't find install directory at '$INSTALL_DIR'"
  echo "       Terminating further execution."

  exit 1
fi

if [ -d "$INSTALL_DIR/.git" ]; then
  echo "Feching newest version..."
  git pull
else
  echo "ERROR: Couldn't find Git repo in install directory at '$INSTALL_DIR'"
  echo "       Terminating further execution."
  echo "       Please check if the directory exists and if it a valid Git repo"

  exit 1
fi

# Symlink hooks
for hook in $HOOKS
do
  hook_path=$INSTALL_DIR/hooks/$hook

  if [ ! -f "$hook_path" ]; then
    echo "Creating link for '$hook' hook"
    ln -s $BASE_HOOK_PATH $hook_path
  else
    echo "WARNING: File for hook '$hook' already exists at '$hook_path'"
    echo "         If you want to override the file, remove it manually and"
    echo "         and re-run this script."
  fi
done

# Configurte GIT
echo "Setting template directory to '$INSTALL_DIR'"
git config --global init.templatedir $INSTALL_DIR
