##################
### BASE (FIRST)
##################
FROM quay.io/criticaljuncture/baseimage:16.04


##################
### RUBY
##################

RUN apt-get update && apt-get install -y ruby2.5 ruby2.5-dev


##################
### PACKAGES
##################

# libsqlite3-dev is dependency of the fast import gem
RUN apt-get update && apt-get install -y build-essential git mysql-client libmysqlclient-dev libsqlite3-dev nodejs &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/


##################
### TIMEZONE
##################

RUN ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime


##################
### SERVICES
##################

COPY docker/web/service/web/run /etc/service/web/run
COPY docker/web/my_init.d /etc/my_init.d

RUN adduser app -uid 1000 --system
RUN usermod -a -G docker_env app


###############################
### GEMS & PASSENGER INSTALL
###############################

RUN gem install bundler -v '~> 1.16.3'
WORKDIR /tmp
COPY Gemfile /tmp/Gemfile
COPY Gemfile.lock /tmp/Gemfile.lock
RUN bundle install --system &&\
  passenger-config install-standalone-runtime &&\
  passenger start --runtime-check-only

# docker cached layer build optimization:
# caches the latest security upgrade versions
# at the same time we're doing something else slow (changing the bundle)
# but something we do often enough that the final unattended upgrade at the
# end of this dockerfile isn't installing the entire world of security updates
# since we set up the dockerfile for the project
RUN apt-get update && unattended-upgrade -d

ENV PASSENGER_MIN_INSTANCES 1
ENV WEB_PORT 3000


##################
### APP
##################

USER app
COPY --chown=1000:1000 . /home/app/

WORKDIR /home/app

RUN SUBDOMAIN=dev SECRET_KEY_BASE=XXX DEVISE_SECRET_KEY=XXXXXXXXX RAILS_ENV=production rake assets:precompile

USER root


##################
### BASE (LAST)
##################

# ensure all packages are as up to date as possible
# installs all updates since we last bundled
RUN apt-get update && unattended-upgrade -d

ENV TERM=linux
