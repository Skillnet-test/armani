#!/bin/sh
################################################################
#	pos.sh
################################################################
. ./javaenv.sh

if [ -e ../log/client.out ] ; then
    mv ../log/client.out ../log/client_last.out
fi

if [ -e ../log/client.err ] ; then
    mv ../log/client.err ../log/client_last.err
fi    

##########################################
#	Needed by IBM		  	 #
##########################################
#stty -F /dev/ttyS0 raw

################################################################
#	Run POS
################################################################
java -showversion -DREDIRECT=false -Djava.security.policy=../../library/policy -DUSER_CONFIG=client_master.cfg -DSTATS_CLASS=com.chelseasystems.cr.node.LinuxProcessStats com.chelseasystems.cr.appmgr.AppManager