#!/bin/sh

if [ -z "$LOGMATIC_TOKEN" ]; then
   echo 'LOGMATIC_TOKEN is required!'
   exit 1
fi

if [ -z "$LOGMATIC_HOSTNAME" ]; then
    echo "LOGMATIC_HOSTNAME not defined, using `hostname`"
    export LOGMATIC_HOSTNAME='%HOSTNAME%'
fi

export LOGMATIC_TAGS=`echo $LOGMATIC_TAGS | sed -e s,'"','\\\\\\\"',g`

# Create spool directory
mkdir -p /var/spool/rsyslog
# Create rsyslog conf directory
mkdir -p /etc/rsyslog.d

if [ "$LOGMATIC_DEBUG" = true ]; then
  sed -i "/\*\.\* @@api\.logmatic\.io.*/a \*\.\* \:omstdout\:" /etc/rsyslog.conf
fi

# Replace variables
sed -i "s/__LOGMATIC_TOKEN__/$LOGMATIC_TOKEN/" /etc/rsyslog.conf
sed -i "s/__LOGMATIC_TAGS__/$LOGMATIC_TAGS/" /etc/rsyslog.conf
sed -i "s/__LOGMATIC_HOSTNAME__/$LOGMATIC_HOSTNAME/" /etc/rsyslog.conf

# Run RSyslog daemon
exec /usr/sbin/rsyslogd -n
