#!/usr/bin/env bash

#
# The $COMMITS is always compared with master
#
# The $PATTERN should contain one pattern per line, e.g:
# line, e.g:
#
# ^.*@domain.com$
# ^allowed@example.com$
#
source $(dirname $0)/_colors-setup.sh

git fetch --all
git checkout master
git checkout "$CI_COMMIT_REF_NAME"

COMMITS=$(git --no-pager log master..$CI_COMMIT_REF_NAME --pretty="%h %ae" --no-merges)
IFS=$'\n'; COMMITS_AS_ARRAY=( $COMMITS ); IFS=' '

PATTERN="^.*@halfhelix.com$"

if [[ -z "$COMMITS" ]]; then
  echo "$FAIL"
  echo "${YELLOW}No commits, this is not normal, exiting...${DEFAULT}"
  exit 1
fi

for COMMIT in "${COMMITS_AS_ARRAY[@]}"; do
  data=( $COMMIT )
  sha=${data[0]}
  email=${data[1]}

  echo "Validating user email ${YELLOW}$email${DEFAULT}, commit (${YELLOW}$sha${DEFAULT})..."
  if [[ ! $sha ]]; then
    echo "Continuing"
    continue
  fi
  grep -q "$PATTERN" <<< "$email"
  MATCH="$?"
  if [ "$MATCH" -ne 0 ]; then
    echo "Email address ${YELLOW}$email${DEFAULT} in commit ${YELLOW}$sha${DEFAULT} does not match the expected pattern."
    echo "$FAIL"
    exit 1
  fi
done

echo "$OK"
exit
