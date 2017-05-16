#!/bin/bash
set -e
if [[ -n "${OPENPROJECT_MANAGED_REPOS}" ]]; then
    ln -snf /opt/app-root/src/config/configuration.yml /opt/app-root/etc/configuration.yml
fi
bundle install
RAILS_ENV=production bundle exec rake db:migrate
#RAILS_ENV=production bundle exec rake generate_secret_token

