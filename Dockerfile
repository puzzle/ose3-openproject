FROM puzzle/ose3-unicorn

ENV RAILS_ENV production
ENV SECRET_KEY_BASE aienhat423490g8iretuk
ENV OPENPROJECT_VERSION v6.1.5

USER root
WORKDIR /opt/app-root/src
COPY .s2i/bin/ $STI_SCRIPTS_PATH
COPY etc/ /opt/app-root/etc/
COPY bin/ /opt/app-root/bin/
COPY Gemfile.plugins .
COPY database.yml config/
COPY production.rb config/environments/
RUN yum install -y git subversion \
 && scl enable rh-nodejs4 "npm install -g npm@4.0 bower" \
 && scl enable rh-ruby23 "gem install bundler" \
 && yum -y install python python-devel python-pip \
 && pip install devcron \
 && chown -R 1001:1001 /opt/app-root \
 && chmod -R go+rx /opt/app-root/bin
USER 1001
