@echo off
del stg_store.log
del stg_store.bad
echo Ext_User  %1
echo Ext_Pass  %2
echo Ext_DB    %3
echo Data_File %4
echo Reg_User  %5
echo Reg_Pass  %6
echo Reg_DB    %7
echo Start_Time %8
sqlldr %1/%2@%3 control=stg_store.ctl data=%4 log=stg_store.log
type stg_store.log
pause
call ../javaenvserver.bat
java com.chelseasystems.cs.armaniinterfaces.ArmStgStoreUpdate %8 STORE %4
