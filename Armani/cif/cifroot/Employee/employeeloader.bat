@echo off
cd Employee
del stg_employee.log
del stg_employee.bad
echo Ext_User  %1
echo Ext_Pass  %2
echo Ext_DB    %3
echo Data_File %4
echo Reg_User  %5
echo Reg_Pass  %6
echo Reg_DB    %7
echo Start_Date   %8
sqlldr %1/%2@%3 control=stg_employee.ctl bad=stg_employee.bad data=%4 log=stg_employee.log
type stg_employee.log
pause
call ../javaenvserver.bat
java com.chelseasystems.cs.armaniinterfaces.ArmStgEmployeeUpdate %8 EMPLOYEE %4
