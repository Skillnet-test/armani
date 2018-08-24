@echo off
TITLE Retek ISO-RPOS Node RNS Server...

call javaenvServer.bat

java -DNS_SERIALIZE=TRUE -DNS_SERIALIZE_DIR=monitor_rns -DNS_PORT=2501 -DNS_LOAD_BALANCE=TRUE -DNS_MONITOR=TRUE -DNS_REDIRECT=FALSE -Djava.security.policy=../../library/policy -Djavax.net.ssl.trustStore=../../library/jssecerts com.igray.naming.RMINamingService
