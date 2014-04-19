#!/bin/bash
# barakafrites daemon
# chkconfig: 345 20 80
# description: barakafrites daemon
# processname: barakafrites

PIDDIR=/var/run/barakafrites
PIDFILE=/var/run/barakafrites/puma.pid
DAEMON_PATH="/srv/barakafrites/sources/barakafrites"
DAEMON="bundle exec puma"
DAEMONOPTS="-e production -b unix:///var/run/barakafrites/puma.sock -p $PIDFILE"
DAEMONUSER=barakafrites

NAME=barakafrites
DESC="Start puma and load barakafrites"

SCRIPTNAME=/etc/init.d/$NAME

case "$1" in
start)
	printf "%-50s" "Starting $NAME..."

	# If directory does not exists, create it
	if [ ! -d $PIDDIR ]; then
	    mkdir $PIDDIR
	    chown -R $DAEMONUSER $PIDDIR
	fi

	su - $DAEMONUSER -c "cd $DAEMON_PATH && exec $DAEMON $DAEMONOPTS > /dev/null 2>&1 &"

;;
status)
        printf "%-50s" "Checking $NAME..."
        if [ -f $PIDFILE ]; then
            PID=`cat $PIDFILE`
            if [ -z "`ps axf | grep ${PID} | grep -v grep`" ]; then
                printf "%s\n" "Process dead but pidfile exists"
            else
                echo "Running"
            fi
        else
            printf "%s\n" "Service not running"
        fi
;;
stop)
        printf "%-50s" "Stopping $NAME"
            PID=`cat $PIDFILE`
            cd $DAEMON_PATH
        if [ -f $PIDFILE ]; then
            kill -HUP $PID
            printf "%s\n" "Ok"
            rm -f $PIDFILE
        else
            printf "%s\n" "pidfile not found"
        fi
;;

restart)
  	$0 stop
  	$0 start
;;

*)
        echo "Usage: $0 {status|start|stop|restart}"
        exit 1
esac