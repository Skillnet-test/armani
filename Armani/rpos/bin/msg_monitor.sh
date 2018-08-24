#!/bin/sh
#############################
#	Start Message Monitor
############################
. ./javaenvServer.sh

java -DREDIRECT=true -DDEBUG=true com.chelseasystems.cr.node.MessageMonitor
