#!/usr/bin/env bash

INSTALL_DIR="~/.git-templates"
HOOKS="applypatch-msg commit-msg post-update pre-applypatch pre-commit pre-push pre-rebase pre-receive prepare-commit-msg update"

git clone git@github.com:stankec/git-hooks-manager.git $INSTALL_DIR
cd $INSTALL_DIR

for hook in $HOOKS
do
  ln -s .base_hook.sh $INSTALL_DIR/hooks/$hook
done
