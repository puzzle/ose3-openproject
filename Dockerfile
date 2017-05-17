FROM centos/ruby-23-centos7

ENV RAILS_ENV production
ENV SECRET_KEY_BASE aienhat423490g8iretuk
ENV OPENPROJECT_VERSION v6.1.5

USER root
WORKDIR /opt/app-root/src

COPY bin/ /opt/app-root/bin/
COPY database.yml config/
COPY production.rb config/environments/
COPY etc/ /opt/app-root/etc/
COPY Gemfile.plugins .

RUN yum install -y epel-release \
 && yum -y update \
 && yum -y install python python-devel python-pip git subversion \
 && scl enable rh-nodejs4 "npm install -g npm@4.0 bower" \
 && scl enable rh-ruby23 "gem install bundler" \
 && pip install devcron \
 && chown -R 1001:1001 /opt/app-root \
 && chmod -R o+x /opt/app-root/bin \
 && git config --global user.name Openshift \
 && git config --global user.email systems@puzzle.ch

COPY .s2i/bin/ $STI_SCRIPTS_PATH

USER 1001
