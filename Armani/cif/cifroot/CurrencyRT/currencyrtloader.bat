@echo off
cd  CurrencyRT
del stg_currency_rt.log
del stg_currency_rt.bad
echo Ext_User   %1
echo Ext_Pass   %2
echo Ext_DB     %3
echo Data_File  %4
echo Reg_User   %5
echo Reg_Pass   %6
echo Reg_DB     %7
echo Start_Time %8
sqlldr  %1/%2@%3 control=stg_currency_rt.ctl bad=stg_currency_rt.bad data=%4 log=stg_currency_rt.log
type stg_currency_rt.log
echo Type Control-C to break
pause
sqlplus %5/%6@%7 @call_load_currency_rt.sql CURRENCY %8 %4
