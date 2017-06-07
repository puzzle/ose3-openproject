#!/bin/bash
if [ "${MANAGE_GIT_REPOS}" == "true" ]; then
    cd /opt/app-root/src
    bundle exec manage_git_repos.rb
fi
