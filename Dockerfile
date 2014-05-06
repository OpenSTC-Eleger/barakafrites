# DOCKER-VERSION 0.9.0

FROM ubuntu:precise
MAINTAINER Siclic "devs@siclic.fr"

RUN apt-get update

# Set terminal type to linux
ENV TERM linux

# Install git and curl
RUN apt-get install -qy git curl

# install RVM stuff
RUN curl -sSL https://get.rvm.io | bash -s stable

# Set Shell env
RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc

# install latest ruby 2.0. RVM needs a login shell to work

RUN /usr/local/rvm/bin/rvm-shell -c "rvm requirements"
RUN /usr/local/rvm/bin/rvm-shell -c "rvm install 2.1"
RUN /bin/bash -l -c "rvm use 2.1 --default"
RUN /bin/bash -l -c "rvm use 2.1 && rvm gemset create barakafrites"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Add service user barakafrites
# RUN useradd --system --home /barakafrites --shell /bin/bash --gid rvm barakafrites

# Inject application dependencies
WORKDIR /tmp

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
ADD .ruby-version .ruby-version
ADD .ruby-gemset .ruby-gemset
ADD vendor/gems/session_off vendor/gems/session_off

# Install barakafrites depedencies
RUN /bin/bash -l -c "rvm gemset use barakafrites && bundle install"

# Inject sources
# to use local changes :
# docker run -P -i -v .:/src -w /src siclic/barakafrites /bin/bash

WORKDIR /src
ADD app app
ADD lib lib
ADD config config
ADD db db
ADD Gemfile Gemfile
ADD Gemfile Gemfile.lock
ADD Rakefile Rakefile
ADD script script
ADD vendor vendor
ADD bin bin
ADD config.ru config.ru
ADD public public
ADD tmp tmp

# Remove Unused building packages to slim image
RUN apt-get remove -qy --auto-remove --purge git curl build-essential

# Set permissions on /barakafrites and switch to barakafrites user
# RUN chown -R barakafrites /barakafrites
# USER barakafrites


