#!/usr/bin/env bash

# Echo CI environment name
echo "CI Environment = ${YELLOW}$CI_ENVIRONMENT_NAME${DEFAULT}"
echo "OS = ${YELLOW}$OSTYPE${DEFAULT}"

# Handle environments. Password, API Key and Store
# Can be configured to be different per environment
case $CI_ENVIRONMENT_NAME in
  staging)
    HEROKU_APP="$HEROKU_APP_STAGING"
  ;;
  production)
    HEROKU_APP="$HEROKU_APP_PRODUCTION"
  ;;
esac

if [ -z "$CI_ENVIRONMENT_NAME" ]; then
  source ./scripts/__env.sh
fi
