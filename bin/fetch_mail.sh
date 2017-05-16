#!/bin/bash
if [ -n "${REDMINE_MAIL_INTEGRATION}" ]; then
  cd /opt/app-root/src
  IMAP_SETTINGS=""
  if [ -n "${RAILS_MAIL_IMAP_HOST}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} host=${RAILS_MAIL_IMAP_HOST}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_PORT}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} port=${RAILS_MAIL_IMAP_PORT}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_SSL}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} ssl=${RAILS_MAIL_IMAP_SSL}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_USERNAME}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} username=${RAILS_MAIL_IMAP_USERNAME}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_PASSWORD}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} password=${RAILS_MAIL_IMAP_PASSWORD}"
  fi
  IMAP_SETTINGS="${IMAP_SETTINGS} allow_override=project,tracker,status,priority,category,assigned_to,fixed_version,start_date,due_date,estimated_hours,done_ratio"
  bundle exec rake redmine:email:receive_imap $IMAP_SETTINGS
else
  echo "Mail cron is disabled set ENV REDMINE_MAIL_INTEGRATION to enable Fetch Mail cron job"
fi
