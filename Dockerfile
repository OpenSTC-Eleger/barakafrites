# DOCKER-VERSION 0.9.0

FROM ubuntu:12.04
MAINTAINER Siclic "devs@siclic.fr"

# Set some ENV variables
ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu precise-updates main universe" >> /etc/apt/sources.list
RUN apt-get update

# Install git and curl
RUN apt-get install -y git curl

# install RVM stuff
RUN curl -sSL https://get.rvm.io | bash -s stable

# Create Supervisor logdir
RUN mkdir -p /var/log/supervisor
# Create application directories
RUN mkdir -p /srv/barakafrites/tmp
RUN mkdir -p /srv/barakafrites/run
RUN mkdir -p /srv/barakafrites/log
# Add service user barakafrites
RUN useradd --system --home /srv/barakafrites --shell /bin/bash --gid rvm barakafrites

# Set wordir for following RUN, ...
WORKDIR /srv/barakafrites

# install latest ruby 2.0. RVM needs a login shell to work
RUN /usr/local/rvm/bin/rvm-shell -c "rvm requirements"
RUN /usr/local/rvm/bin/rvm-shell -c "rvm install 2.1"
RUN /bin/bash -l -c "rvm use 2.1 --default"
RUN /bin/bash -l -c "rvm use 2.1 && rvm gemset create barakafrites"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Add application dependencies
ADD Gemfile /srv/barakafrites/Gemfile
ADD .ruby-version /srv/barakafrites/.ruby-version
ADD .ruby-gemset /srv/barakafrites/.ruby-gemset
ADD vendor /srv/barakafrites/vendor

# Install barakafrites depedencies
RUN /bin/bash -l -c "rvm gemset use barakafrites && bundle install"

# Add application sources in container (order kind of matters !)
# First those that don't change much
ADD config.ru /srv/barakafrites/config.ru
RUN mkdir -p /srv/barakafrites/script
ADD script/rails /srv/barakafrites/script/rails
ADD script/start.sh /srv/barakafrites/script/start.sh
RUN chmod +x /srv/barakafrites/script/start.sh
ADD Rakefile /srv/barakafrites/Rakefile
ADD bin /srv/barakafrites/bin
ADD public /srv/barakafrites/public
# Then those that might change a lot
ADD lib /srv/barakafrites/lib
ADD app /srv/barakafrites/app
ADD db /srv/barakafrites/db
ADD config /srv/barakafrites/config

RUN chown -R barakafrites /srv/barakafrites

# Put our startup script
ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

# The app listens on port 9292
EXPOSE 9292

USER barakafrites
# Finally executes our startup script
# Args passed to the 'docker run' command will be available to the script
CMD /usr/local/bin/run
