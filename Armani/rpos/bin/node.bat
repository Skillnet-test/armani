@echo off
TITLE Retek ISO-RPOS Node Server...

call javaenvServer.bat

java -DREDIRECT=false -DCONFIG_FILE=monitor.cfg -Djava.security.policy=../../library/policy -Djavax.net.ssl.trustStore=../../library/jssecerts com.chelseasystems.cr.node.NodeMonitorImpl
