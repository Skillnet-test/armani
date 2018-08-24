#!/bin/sh
######################################
#	Start Node_rns
######################################
. ./javaenvServer.sh

java -DNS_SERIALIZE=TRUE -DNS_SERIALIZE_DIR=monitor_rns -DNS_PORT=3001 -DNS_LOAD_BALANCE=TRUE -DNS_MONITOR=TRUE -DREDIRECT=TRUE -DMESSENGERS=com.chelseasystems.cr.messaging.InformationMessageSender,com.chelseasystems.cr.messaging.ExceptionMessageSender -DDEFAULT_GROUP=RTK.USA.Server -Djava.security.policy=../../library/policy -Djavax.net.ssl.trustStore=../../library/jssecerts com.igray.naming.RMINamingService

