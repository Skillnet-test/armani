@echo off
TITLE Retek ISO-RPOS RNS Server...

call javaenvServer.bat

java -DNS_SERIALIZE=TRUE -DNS_SERIALIZE_DIR=rns_dir -DNS_PORT=3000 -DNS_LOAD_BALANCE=TRUE -DNS_MONITOR=TRUE -DNS_REDIRECT=FALSE -Djava.security.policy=../../library/policy -Djavax.net.ssl.trustStore=../../library/jssecerts com.igray.naming.RMINamingService
