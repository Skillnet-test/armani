#! /bin/bash
cd ./Store
rm stg_store.log
rm stg_store.bad
echo ------------------
echo Parameters passed:
echo ------------------
Ext_User=$1
echo Ext_User  $Ext_User
Ext_Pass=$2
echo Ext_Pass  $Ext_Pass
Ext_DB=$3
echo Ext_DB $Ext_DB
Data_File=$4
echo Data_File $Data_File
Reg_User=$5
echo Reg_User $Reg_User
Reg_Pass=$6
echo Reg_Pass $Reg_Pass
Reg_DB=$7
echo Reg_DB $Reg_DB
Start_Time=$8
echo Start_Time $Start_Time
error_code=0
sqlldr $Ext_User/$Ext_Pass@$Ext_DB control=stg_store.ctl bad=stg_store.bad data=$Data_File log=stg_store.log 1>outputLog.txt 2>errorLog.txt
error_code=$?

echo The log created by the SQL Loader is:
#cat stg_store.log
cd ..
. ./javaenvServer.sh
java com.chelseasystems.cs.armaniinterfaces.ArmStgStoreUpdate $Start_Time STORE $Date_File 0 1>outputLog.txt 2>errorLog.txt

if [ "$?" -ne 0 ]
then
    exit "$?"
fi
cd ./Store
exit $error_code
