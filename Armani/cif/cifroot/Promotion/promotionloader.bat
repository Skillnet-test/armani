@echo off
cd Promotion
del stg_promotion.log
del stg_promotion.bad
echo Ext_User  %1
echo Ext_Pass  %2
echo Ext_DB    %3
echo Data_File %4
echo Reg_User  %5
echo Reg_Pass  %6
echo Reg_DB    %7
echo Start_Time %8
sqlldr %1/%2@%3 control=stg_promotion.ctl bad=stg_promotion.bad data=%4 log=stg_promotion.log
type stg_promotion.log
pause
ccall ../javaenvserver.bat
java com.chelseasystems.cs.dataaccess.PosPromDetailLoader %8 PROMOTION %4
