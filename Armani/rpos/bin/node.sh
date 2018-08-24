#!/bin/sh
####################################
#	Start Node 
###################################
. ./javaenvServer.sh

java -DREDIRECT=true -DCONFIG_FILE=monitor.cfg -Djava.security.policy=../../library/policy -Djavax.net.ssl.trustStore=../../library/jssecerts com.chelseasystems.cr.node.NodeMonitorImpl
