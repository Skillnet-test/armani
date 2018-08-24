#!/bin/sh
###################################
#	Start Node 
###################################
. ./javaenvServer.sh

java -DNS_SERIALIZE=TRUE -DNS_SERIALIZE_DIR=rns_dir -DNS_PORT=3000 -DNS_LOAD_BALANCE=TRUE -DNS_MONITOR=TRUE -DNS_REDIRECT=TRUE -DMESSENGERS=com.chelseasystems.cr.messaging.InformationMessageSender,com.chelseasystems.cr.messaging.ExceptionMessageSender -DDEFAULT_GROUP=RTK.USA.Server -Djava.security.policy=../../library/policy -Djavax.net.ssl.trustStore=../../library/jssecerts com.igray.naming.RMINamingService

