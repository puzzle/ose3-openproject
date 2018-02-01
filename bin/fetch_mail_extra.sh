#!/bin/bash
if [ -n "${REDMINE_MAIL_INTEGRATION}" ]; then
  cd /opt/app-root/src

# Fetch Mails for extra account 1
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
    if [ -n "${RAILS_MAIL_IMAP_USERNAME_E1}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} username=${RAILS_MAIL_IMAP_USERNAME_E1}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_PASSWORD_E1}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} password=${RAILS_MAIL_IMAP_PASSWORD_E1}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_PROJECT_E1}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} project=${RAILS_MAIL_IMAP_DEFAULT_PROJECT_E1}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_TYPE_E1}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} type=${RAILS_MAIL_IMAP_DEFAULT_TYPE_E1}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_STATUS_E1}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} status=${RAILS_MAIL_IMAP_DEFAULT_STATUS_E1}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_PRIORITY_E1}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} priority=${RAILS_MAIL_IMAP_DEFAULT_PRIORITY_E1}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_VERSION_E1}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} fixed_version=${RAILS_MAIL_IMAP_DEFAULT_VERSION_E1}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_MOVE_E1}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} move_on_success=${RAILS_MAIL_IMAP_DEFAULT_MOVE_E1}"
    fi
    IMAP_SETTINGS="${IMAP_SETTINGS}  no_permission_check=1 allow_override=project,tracker,type,status,priority,category,assigned_to,fixed_version,start_date,due_date,estimated_hours,done_ratio"
    bundle exec rake redmine:email:receive_imap $IMAP_SETTINGS

# Fetch Mails for extra account 2
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
    if [ -n "${RAILS_MAIL_IMAP_USERNAME_E2}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} username=${RAILS_MAIL_IMAP_USERNAME_E2}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_PASSWORD_E2}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} password=${RAILS_MAIL_IMAP_PASSWORD_E2}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_PROJECT_E2}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} project=${RAILS_MAIL_IMAP_DEFAULT_PROJECT_E2}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_TYPE_E2}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} type=${RAILS_MAIL_IMAP_DEFAULT_TYPE_E2}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_STATUS_E2}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} status=${RAILS_MAIL_IMAP_DEFAULT_STATUS_E2}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_PRIORITY_E2}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} priority=${RAILS_MAIL_IMAP_DEFAULT_PRIORITY_E2}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_VERSION_E2}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} fixed_version=${RAILS_MAIL_IMAP_DEFAULT_VERSION_E2}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_MOVE_E2}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} move_on_success=${RAILS_MAIL_IMAP_DEFAULT_MOVE_E2}"
    fi
    IMAP_SETTINGS="${IMAP_SETTINGS} no_permission_check=1 allow_override=project,tracker,type,status,priority,category,assigned_to,fixed_version,start_date,due_date,estimated_hours,done_ratio"
    bundle exec rake redmine:email:receive_imap $IMAP_SETTINGS

# Fetch Mails for extra account 3
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
    if [ -n "${RAILS_MAIL_IMAP_USERNAME_E3}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} username=${RAILS_MAIL_IMAP_USERNAME_E3}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_PASSWORD_E3}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} password=${RAILS_MAIL_IMAP_PASSWORD_E3}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_PROJECT_E3}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} project=${RAILS_MAIL_IMAP_DEFAULT_PROJECT_E3}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_TYPE_E3}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} type=${RAILS_MAIL_IMAP_DEFAULT_TYPE_E3}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_STATUS_E3}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} status=${RAILS_MAIL_IMAP_DEFAULT_STATUS_E3}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_PRIORITY_E3}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} priority=${RAILS_MAIL_IMAP_DEFAULT_PRIORITY_E3}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_VERSION_E3}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} fixed_version=${RAILS_MAIL_IMAP_DEFAULT_VERSION_E3}"
    fi
    if [ -n "${RAILS_MAIL_IMAP_DEFAULT_MOVE_E3}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} move_on_success=${RAILS_MAIL_IMAP_DEFAULT_MOVE_E3}"
    fi
    IMAP_SETTINGS="${IMAP_SETTINGS} no_permission_check=1 allow_override=project,tracker,type,status,priority,category,assigned_to,fixed_version,start_date,due_date,estimated_hours,done_ratio"
    bundle exec rake redmine:email:receive_imap $IMAP_SETTINGS


else
  echo "Mail cron is disabled set ENV REDMINE_MAIL_INTEGRATION to enable Fetch Mail cron job"
fi
