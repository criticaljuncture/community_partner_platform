##################
### BASE (FIRST)
##################

FROM quay.io/criticaljuncture/baseimage:16.04

# Update apt
RUN apt-get update && apt-get install vim curl build-essential -y


##################
### RUBY
##################

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6 &&\
  echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox.list &&\
  apt-get update &&\
  apt-get install -y ruby2.3 ruby2.3-dev &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


##################
### PACKAGES
##################

# libsqlite3-dev is dependency of the fast import gem
RUN apt-get update && apt-get install -y build-essential git libmysqlclient-dev libsqlite3-dev nodejs &&\
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

RUN gem install bundler
WORKDIR /tmp
COPY Gemfile /tmp/Gemfile
COPY Gemfile.lock /tmp/Gemfile.lock
RUN bundle install --system &&\
  passenger-config install-standalone-runtime &&\
  passenger start --runtime-check-only

ENV PASSENGER_MIN_INSTANCES 1
ENV WEB_PORT 3000


##################
### APP
##################

COPY . /home/app/

WORKDIR /home/app
RUN mkdir -p tmp/pids
RUN chown -R app /home/app
RUN SUBDOMAIN=dev DEVISE_SECRET_KEY=XXXXXXXXX RAILS_ENV=production rake assets:precompile &&\
  chown -R app /home/app


##################
### BASE (LAST)
##################

# ensure all packages are up to date
RUN apt-get update && unattended-upgrade -d

ENV TERM=linux
