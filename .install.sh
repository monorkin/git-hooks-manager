#!/usr/bin/env bash

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
if [ ! -f "$GITCONFIG_PATH" ]; then
  echo "Creating GitConfig at '$GITCONFIG_PATH'"
  touch $GITCONFIG_PATH
fi

if [ ! -z "$(cat $GITCONFIG_PATH | grep -Ei "templatedir\s*=")" ]; then
  echo "WARNING: The 'init.templatedir' option is already set in your GitConfig"
  echo "         file (here '$GITCONFIG_PATH')."
  echo "         Please change it's value to '$INSTALL_DIR'."
else
  echo "Appending template dir config to GitConfig"
  echo "[init]\n  templatedir = $INSTALL_DIR" >> $GITCONFIG_PATH
fi
