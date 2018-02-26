#!/bin/bash
# Bash script to fetch mails from extra mail accounts with corresponding default parameters
# This is a workaround for the limitation of openroject, which allows only one single mail account to be configured


# First, check if Mail is enabled at all:
if [ -n "${REDMINE_MAIL_INTEGRATION}" ]; then
  cd /opt/app-root/src

  # IMAP Settings, that apply to all mail accounts, need to be set only once:
  IMAP_SETTINGS_BASE=""
  if [ -n "${RAILS_MAIL_IMAP_HOST}" ]; then
    IMAP_SETTINGS_BASE="${IMAP_SETTINGS_BASE} host=${RAILS_MAIL_IMAP_HOST}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_PORT}" ]; then
    IMAP_SETTINGS_BASE="${IMAP_SETTINGS_BASE} port=${RAILS_MAIL_IMAP_PORT}"
  fi
  if [ -n "${RAILS_MAIL_IMAP_SSL}" ]; then
    IMAP_SETTINGS_BASE="${IMAP_SETTINGS_BASE} ssl=${RAILS_MAIL_IMAP_SSL}"
  fi

  # Check ENV-Variable for how many extra mail accounts are configured?
  NUMBER_OF_ACCOUNTS=${RAILS_MAIL_IMAP_NUMBER_OF_ACCOUNTS}

  # Now fetch mails from each extra mail account: 
  for (( e=1; e<=${NUMBER_OF_ACCOUNTS}; e++ ))
  do
    IMAP_SETTINGS=${IMAP_SETTINGS_BASE}

    # set names of the variables that contain settings for the current mail account in this loop:
    VARNAME_RAILS_MAIL_IMAP_USERNAME=RAILS_MAIL_IMAP_USERNAME_E${e}
    VARNAME_RAILS_MAIL_IMAP_PASSWORD=RAILS_MAIL_IMAP_PASSWORD_E${e}
    VARNAME_RAILS_MAIL_IMAP_DEFAULT_PROJECT=RAILS_MAIL_IMAP_DEFAULT_PROJECT_E${e}
    VARNAME_RAILS_MAIL_IMAP_DEFAULT_TYPE=RAILS_MAIL_IMAP_DEFAULT_TYPE_E${e}
    VARNAME_RAILS_MAIL_IMAP_DEFAULT_PRIORITY=RAILS_MAIL_IMAP_DEFAULT_PRIORITY_E${e}
    VARNAME_RAILS_MAIL_IMAP_DEFAULT_VERSION=RAILS_MAIL_IMAP_DEFAULT_VERSION_E${e}
    VARNAME_RAILS_MAIL_IMAP_DEFAULT_MOVE=RAILS_MAIL_IMAP_DEFAULT_MOVE_E${e}

    # if no username is set, then skip other checks and don't try to fetch mails
    if [ -n "${!VARNAME_RAILS_MAIL_IMAP_USERNAME}" ]; then
      IMAP_SETTINGS="${IMAP_SETTINGS} username=${!VARNAME_RAILS_MAIL_IMAP_USERNAME}"
    
      if [ -n "${!VARNAME_RAILS_MAIL_IMAP_PASSWORD}" ]; then
        IMAP_SETTINGS="${IMAP_SETTINGS} password=${!VARNAME_RAILS_MAIL_IMAP_PASSWORD}"
      fi
      if [ -n "${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_PROJECT}" ]; then
        IMAP_SETTINGS="${IMAP_SETTINGS} project=${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_PROJECT}"
      fi
      if [ -n "${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_TYPE}" ]; then
        IMAP_SETTINGS="${IMAP_SETTINGS} type=${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_TYPE}"
      fi
      if [ -n "${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_STATUS}" ]; then
        IMAP_SETTINGS="${IMAP_SETTINGS} status=${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_STATUS}"
      fi
      if [ -n "${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_PRIORITY}" ]; then
        IMAP_SETTINGS="${IMAP_SETTINGS} priority=${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_PRIORITY}"
      fi
      if [ -n "${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_VERSION}" ]; then
        IMAP_SETTINGS="${IMAP_SETTINGS} fixed_version=${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_VERSION}"
      fi
      if [ -n "${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_MOVE}" ]; then
        IMAP_SETTINGS="${IMAP_SETTINGS} move_on_success=${!VARNAME_RAILS_MAIL_IMAP_DEFAULT_MOVE}"
      fi
    
    # add some other parameters to the rake task:
    IMAP_SETTINGS="${IMAP_SETTINGS} no_permission_check=1 unknown_user=create allow_override=project,tracker,type,status,priority,category,assigned_to,fixed_version,start_date,due_date,estimated_hours,done_ratio"
    bundle exec rake redmine:email:receive_imap $IMAP_SETTINGS
    fi

  done
else
  echo "Mail cron is disabled set ENV REDMINE_MAIL_INTEGRATION to enable Fetch Mail cron job"
fi
