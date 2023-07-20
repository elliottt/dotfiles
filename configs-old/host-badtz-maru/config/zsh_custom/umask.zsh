#!/usr/bin/env zsh

# On windows subsystem for linux, the default umask is 000. This is easily
# fixed, but if left alone will cause strange issues with git checkouts and
# directory creation.
#
# https://www.turek.dev/post/fix-wsl-file-permissions/
if [ "$(umask)" = "000" ]; then
  umask 022
fi
