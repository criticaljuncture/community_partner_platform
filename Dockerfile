FROM quay.io/criticaljuncture/baseimage

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C3173AA6 &&\
  echo deb http://ppa.launchpad.net/brightbox/ruby-ng/ubuntu trusty main > /etc/apt/sources.list.d/brightbox.list &&\
  apt-get update &&\
  apt-get install -y ruby2.3 ruby2.3-dev &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# libsqlite3-dev is dependency of the fast import gem
RUN apt-get update && apt-get install -y build-essential git libmysqlclient-dev libsqlite3-dev nodejs &&\
  apt-get clean &&\
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

RUN gem install passenger --version 5.0.30
RUN passenger start --runtime-check-only

RUN ln -sf /usr/share/zoneinfo/US/Pacific /etc/localtime

RUN gem install bundler

COPY docker/web/service/web/run /etc/service/web/run
COPY docker/web/my_init.d /etc/my_init.d

RUN adduser app -uid 1000 --system

RUN gem install bundler
WORKDIR /tmp
COPY Gemfile /tmp/Gemfile
COPY Gemfile.lock /tmp/Gemfile.lock
RUN bundle install --system

ENV DEVISE_SECRET_KEY XXXXXXXXX

COPY . /home/app/

WORKDIR /home/app
COPY config/secrets.yml config/secrets.yml
RUN RAILS_ENV=production rake assets:precompile &&\
  chown -R app /home/app
