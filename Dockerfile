##################
### BASE (FIRST)
##################
FROM quay.io/criticaljuncture/baseimage:20.04


##################
### RUBY
##################

ARG RUBY_VERSION=3.1-jemalloc

# install ruby
RUN apt update &&\
   apt install -y \
     # ruby
     fullstaq-ruby-common fullstaq-ruby-${RUBY_VERSION} &&\
   apt-get clean &&\
   apt-get autoremove &&\
   apt-get purge &&\
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/


##################
### PACKAGES
##################

# libsqlite3-dev is dependency of the fast import gem
RUN apt-get update && apt-get install -y \
    build-essential git mysql-client libmysqlclient-dev \
    libssl-dev libsqlite3-dev nodejs &&\
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


###############################
### APP USER/GROUP
###############################

RUN adduser app -uid 1000 --system &&\
  usermod -a -G docker_env app

# switch to app user automatically when exec into container
RUN echo 'su app -s /bin/bash' | tee -a /root/.bashrc


###############################
### ADDITIONAL RUBY SETUP
###############################

# make available in default path
ENV PATH="/usr/lib/fullstaq-ruby/versions/${RUBY_VERSION}/bin:${PATH}"
RUN echo "PATH="${PATH}"" > /etc/environment


###############################
### GEMS & PASSENGER INSTALL
###############################

RUN gem install bundler

WORKDIR /tmp
COPY Gemfile /tmp/Gemfile
COPY Gemfile.lock /tmp/Gemfile.lock
RUN bundle install &&\
  passenger-config install-standalone-runtime &&\
  passenger start --runtime-check-only


# docker cached layer build optimization:
# caches the latest security upgrade versions
# at the same time we're doing something else slow (changing the bundle)
# but something we do often enough that the final unattended upgrade at the
# end of this dockerfile isn't installing the entire world of security updates
# since we set up the dockerfile for the project
# RUN apt-get update && unattended-upgrade -d

ENV PASSENGER_MIN_INSTANCES 1
ENV WEB_PORT 3000


##################
### APP
##################

COPY --chown=1000:1000 . /home/app/

WORKDIR /home/app

RUN SUBDOMAIN=dev SECRET_KEY_BASE=XXX DEVISE_SECRET_KEY=XXXXXXXXX RAILS_ENV=production rake assets:precompile &&\
  chown -R app /home/app


##################
### BASE (LAST)
##################

# ensure all packages are as up to date as possible
# installs all updates since we last bundled
# RUN apt-get update && unattended-upgrade -d

ENV TERM=linux
