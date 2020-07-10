#!/usr/bin/env bash

#
# The $COMMITS is always compared with master
#
# All commit messages must be at least two words
#
source $(dirname $0)/_colors-setup.sh

git fetch --all
git checkout master
git checkout "$CI_COMMIT_REF_NAME"

COMMITS=$(git --no-pager log master..$CI_COMMIT_REF_NAME --pretty="%s" --no-merges)
IFS=$'\n'; COMMITS_AS_ARRAY=( $COMMITS ); IFS=' '

if [[ -z "$COMMITS" ]]; then
  echo "$FAIL"
  echo "${YELLOW}No commits, this is not normal, exiting...${DEFAULT}"
  exit 1
fi

for COMMIT in "${COMMITS_AS_ARRAY[@]}"; do
  echo "Validating user message ${YELLOW}$COMMIT${DEFAULT}"
  if [[ ! $COMMIT ]]; then
    echo "Continuing"
    continue
  fi
  # $COMMIT | wc -w | read WORD_COUNT
  WORD_COUNT=$(echo -e $COMMIT | wc -w | tr -d '[:space:]')
  if [ "$WORD_COUNT" -lt 1 ]; then
    echo "User message not valid ${YELLOW}$COMMIT${DEFAULT}"
    echo "$FAIL"
    exit 1
  fi

  # FIRST_LETTER="${COMMIT:0:1}"
  # if ! [[ "$FIRST_LETTER" =~ ^[A-Z]{1}$ ]]; then
  #   echo "User message not valid ${YELLOW}$COMMIT${DEFAULT}"
  #   echo "$FAIL"
  #   exit 1
  # fi
done

echo "$OK"
exit