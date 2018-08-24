echo off

call javaenvserver.bat

del .\monitor_rns\*
del .\rns_dir\*

REM echo Starting the database...
REM start startCS.bat
REM for %%i in (1 10) do ping localhost > tmp

echo Starting rns...
start rns.bat
for %%i in (1 10) do ping localhost > tmp

echo Starting node _rns...
start node_rns.bat
for %%i in (1 10) do ping localhost > tmp

echo Starting node...
start node.bat
for %%i in (1 10) do ping localhost > tmp

echo Starting RPOS...
REM start pos.bat