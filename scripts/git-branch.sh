#!/usr/bin/env bash

#
# The current branch must a of type:
# - Feature
# - Bugfix
# - Master
# - Develop
#
source $(dirname $0)/_colors-setup.sh

echo "Current branch = $CI_COMMIT_REF_NAME"

if ! [[ $CI_COMMIT_REF_NAME =~ ^(feature\/.*|bugfix\/.*|master|production)$ ]]; then
  echo "Branch ${YELLOW}$BRANCH${DEFAULT} not valid"
  echo "$FAIL"
  exit 1
fi

echo "$OK"
exit;
