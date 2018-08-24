#!/bin/sh
###########################################
#	start POS
###########################################
mv ../log/client.out ../log/client_last.out
mv ../log/client.err ../log/client_last.err

# Release Wincor JavaPOS locks
/usr/local/javapos/wn/bin/wnjavaposipc -r

java  -showversion -DREDIRECT=false -Djava.security.policy=../../library/policy -DUSER_CONFIG=client_master.cfg -DSTATS_CLASS=com.chelseasystems.cr.node.LinuxProcessStats com.chelseasystems.cr.appmgr.AppManager
