#!/bin/sh
cd ./Item
rm stg_item.log
rm stg_item.bad
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
############################
initFname=$4
origlen=$(expr length $initFname)
cutlen1=$(echo $initFname | awk '{print index($0,"/A")}')
newFnameLen=$(expr $origlen - $cutlen1 + 1)
fname=$(echo $initFname|tail -c $newFnameLen)
#echo datafilename: $fname
len1=$(expr length ARM_STG_ITEM_)
len2=$(expr length $fname)
len=$(expr $len2 - $len1 + 1 - 4)
#echo length: $len1 $len2 $len
timeStamp=$(echo $fname|tail -c $len)
newFileName=stg_item_$timeStamp.ctl
echo newFileName: $newFileName
echo fname: $fname
sed "s/\$FILE_IDENTIFIER/\"$fname\"/g" ./stg_item.ctl > ./ctrl/stg_item_$timeStamp.ctl
#sed "s/\$FILE_IDENTIFIER/\"$timeStamp\"/g" ./stg_item.ctl > ./ctrl/stg_item_$timeStamp.ctl
############################
error_code=0
sqlldr  $Ext_User/$Ext_Pass@$Ext_DB control=./ctrl/stg_item_$timeStamp.ctl data=$Data_File bad=stg_item.bad log=stg_item.log  1>outputLog.txt 2>errorLog.txt
Error_Code=$?
echo The log created by the SQL Loader is:
#cat stg_item.log
sqlplus $Reg_User/$Reg_Pass@$Reg_DB @call_load_item.sql ITEM $Start_Time $Data_File 1>outputLog.txt 2>errorLog.txt
if [ $? -ne 0 ]
then
    exit $? 
fi
rm ./ctrl/stg_item_$timeStamp.ctl
exit $Error_Code
