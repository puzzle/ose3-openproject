#!/bin/bash
if [ -n "${MANAGE_GIT_REPOS}" ]; then
    cd /opt/app-root/src
    bundle exec manage_git_repos.rb
fi
