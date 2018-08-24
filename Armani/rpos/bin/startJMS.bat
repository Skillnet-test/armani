@echo off
TITLE openJMS Server...

set JAVA_HOME=C:\retek\iso_3.0\IBMJava2-131\jre
set OPENJMS_HOME=C:\retek\iso_3.0\openjms-0.7.2

if not exist %OPENJMS_HOME%\bin\startjms.bat goto missingJMS

cd %OPENJMS_HOME%\bin

if exist rposjms.lock del /f /q rposjms.lock
if exist openjms.log del /f /q openjms.log
if exist rposjms.db del /f /q rposjms.db

echo Starting OPEN_JMS Server...
startjms.bat -config ..\config\rpos.xml
goto exitScript


:missingJMS
echo OpenJMS was not found...
pause


:exitScript
exit
