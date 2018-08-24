@echo off
cd Register
del stg_register.log
del stg_register.bad
echo Ext_User  %1
echo Ext_Pass  %2
echo Ext_DB    %3
echo Data_File %4
echo Reg_User  %5
echo Reg_Pass  %6
echo Reg_DB    %7
echo Start_Time %8
sqlldr %1/%2@%3 control=stg_register.ctl bad=stg_register.bad data=%4 log=stg_register.log
type stg_register.log
pause
sqlplus %5/%6@%7 @call_load_register.sql REGISTER %8 %4
