#!/bin/bash

RUNENV=$1
cd /srv/barakafrites
bundle exec puma -e $RUNENV -b tcp://0.0.0.0:9292 -p /srv/barakafrites/run/puma.pid -d
