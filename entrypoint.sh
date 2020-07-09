#! /bin/bash 

LOGFILE="/var/log/apt-cacher-ng/apt-cacher.log"

# the next call will automatically background
/usr/sbin/apt-cacher-ng -c /etc/apt-cacher-ng

touch $LOGFILE
tail -f $LOGFILE
