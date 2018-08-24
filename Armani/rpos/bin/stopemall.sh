#!/bin/ksh

stopCS.sh
sleep 10

# Stop all remaining Java processes
ps -ef | grep /java | awk '{print "kill -9 ",$2}' | ksh
sleep 5

# Remove the lock that would keep us from restarting OpenJMS
rm /usr/opt/app/openjms/bin/*.lock

