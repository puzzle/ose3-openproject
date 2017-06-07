# Puzzle Openproject on OpenShift V3

The Openproject application has four containers: frontend, mysql (+backup) and a cron container. If managed repositories are used an additional Apache container is needed.

The state is saved into three persistent volumes:
* MySQL Data (/var/lib/mysql/data) typically 2GB
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

With persistent volumes and claims (mysql and uploads + repositories) make sure that gluster PVs with the given size(2 GB DB, 5GB Files) are available

```
$ oc new-app -f openproject-template.json -p APPLICATION_DOMAIN_EXT=openproject-stg.puzzle.ch,RAILS_MAIL_IMAP_PASSWORD=***,GIT_CREDENTIALS_gitlab_puzzle_ch=hudson:***
```
If you are using managed repositories and would like to serve them via Apache:
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
Upload Files in directory ./files into the container /opt/app-root/data
```
$ oc rsync files redmine-5-376ju:/opt/app-root/data
```

## Debug

Instructions not complete:
```
$ docker run --name openproject-mysql -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7
$ docker build . -t openproject
$ s2i build --ref v7.0.0 -e OPENPROJECT_PLUGIN_DOCUMENTS=true https://github.com/opf/openproject openproject openproject-s2i
$ docker run --rm -it -p 8080:8080 -e RAILS_DB_NAME=redmine -e RAILS_DB_USERNAME=root -e RAILS_DB_PASSWORD=root -e RAILS_DB_HOST=openproject-mysql -e RAILS_DB_ADAPTER=mysql2 --link openproject-mysql openproject-s2i
```
