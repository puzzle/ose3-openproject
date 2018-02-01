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
  if [ -n "${RAILS_MAIL_IMAP_DEFAULT_PROJECT}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} project=${RAILS_MAIL_IMAP_DEFAULT_PROJECT}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_DEFAULT_TYPE}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} type=${RAILS_MAIL_IMAP_DEFAULT_TYPE}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_DEFAULT_STATUS}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} status=${RAILS_MAIL_IMAP_DEFAULT_STATUS}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_DEFAULT_PRIORITY}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} priority=${RAILS_MAIL_IMAP_DEFAULT_PRIORITY}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_DEFAULT_VERSION}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} fixed_version=${RAILS_MAIL_IMAP_DEFAULT_VERSION}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_DEFAULT_MOVE}" ]; then
    IMAP_SETTINGS="${IMAP_SETTINGS} move_on_success=${RAILS_MAIL_IMAP_DEFAULT_MOVE}"
  fi
  IMAP_SETTINGS="${IMAP_SETTINGS} no_permission_check=1 unknown_user=create default-group=extern allow_override=project,tracker,type,status,priority,category,assigned_to,fixed_version,start_date,due_date,estimated_hours,done_ratio"
  bundle exec rake redmine:email:receive_imap $IMAP_SETTINGS
else
  echo "Mail cron is disabled set ENV REDMINE_MAIL_INTEGRATION to enable Fetch Mail cron job"
fi
