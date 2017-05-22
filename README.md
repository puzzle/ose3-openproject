# Puzzle Openproject on OpenShift V3

Basicly the openproject application consists out of four containers frontend, a Mysql (+backup) and a Cron container.

The state is saved into three persistent Volumes:
* MySQL Data (/var/lib/mysql/data) typically 1GB
* Openproject (files and repositories) (/opt/app-root/data) typically 5GB
* MySQL-backup for dumps

## How to deploy Redmine to OpenShift V3
Login
```
$ oc login [cluster]
```

Create project if it doesn't already exist
```
$ oc new-project pitc-openproject-stg
```

## deploy

With persistent Volumes and claims (mysql + uploads, Git dir) make sure that gluster PVs with the given size(1 GB DB, 2GB Files, 2 GB Git files) are available

```
$ oc new-app -f openproject-template.json -p APPLICATION_DOMAIN_EXT=openproject-stg.puzzle.ch,RAILS_MAIL_IMAP_PASSWORD=***,GIT_CREDENTIALS_gitlab_puzzle_ch=hudson:***
```
If you are using managed repositories and would like to serve them via apache:
```
$ oc new-app puzzle/ose3-openproject:apache -e OPENPROJECT_API_KEY=***
```

## import mysql dump
```
$ oc get pod
NAME                 READY     STATUS      RESTARTS   AGE
mysql-1-03k47        1/1       Running     0          5h

# Upload dump in directory ./dump/ into the container /tmp/dump
$ oc rsync ./dump/ mysql-1-03k47:/tmp/

$ oc rsh mysql-1-03k47
sh-4.2$
$ mysql -uroot redmine < /tmp/dump/dump.sql
```

## upload files
```
$ oc get pod
NAME                 READY     STATUS      RESTARTS   AGE
mysql-1-03k47        1/1       Running     0          5h
redmine-3-build      0/1       Completed   0          48m
redmine-5-376ju      1/1       Running     0          43m

```
Upload Files in directory ./files/ into the container /opt/app-root/src/files
```
$ oc rsync ./files/ redmine-5-376ju:/opt/app-root/src/
```

