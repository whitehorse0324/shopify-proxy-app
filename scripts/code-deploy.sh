#!/usr/bin/env bash

#
# The $COMMITS is always compared with master
#
# All commit messages must be at least two words
#
source $(dirname $0)/_colors-setup.sh
source $(dirname $0)/_variable-setup.sh

# Print out variables
echo ""
echo "App Name = ${YELLOW}$HEROKU_APP${DEFAULT}"
echo "API Key = ${YELLOW}${HEROKU_API_KEY:0:4}xxxxxxxxxx${DEFAULT}"
echo ""

echo "Installing `dpl` gem..."
gem install dpl

echo "${YELLOW}Deploying to Heroku${DEFAULT}"
dpl --provider=heroku --app=$HEROKU_APP --api-key=$HEROKU_API_KEY

echo "Running Rails migrations..."
heroku run rake db:migrate --exit-code -a=$HEROKU_APP

echo "$OK"
exit
