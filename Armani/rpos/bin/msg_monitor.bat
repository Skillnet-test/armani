@echo off
TITLE Retek ISO-RPOS Message Monitor Server....

call javaenvServer.bat

java -DREDIRECT=false -DDEBUG=true com.chelseasystems.cr.node.MessageMonitor
