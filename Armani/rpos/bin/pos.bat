@echo off
TITLE Retek ISO-RPOS...

call javaenv.bat

For /f "Tokens=*" %%i in ('java com.chelseasystems.cs.util.ScriptUtil CurrentDateTimeString yyyyMMddHHmmssSSS') do set rposlogdatetime=%%i

if not exist ..\log\archive md ..\log\archive
if exist ..\log\client.out move ..\log\client.out ..\log\archive\client_%rposlogdatetime%.out
if exist ..\log\client.err move ..\log\client.err ..\log\archive\client_%rposlogdatetime%.err
if exist ..\log\client.log move ..\log\client.log ..\log\archive\client_%rposlogdatetime%.log

attrib  -r ..\files\prod\config\*
attrib  -r ..\files\prod\tmp\*
attrib  -r ..\files\prod\xml\*.xml

java -showversion -DREDIRECT=false -Dcom.chelseasystems.debug=true -Djava.security.policy=../../library/policy -DUSER_CONFIG=client_master.cfg -DSTATS_CLASS=com.chelseasystems.cr.node.WinProcessStats com.chelseasystems.cr.appmgr.AppManager
