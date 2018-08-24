#! /bin/bash
# Script to execute item download
# Set the environment
# customize this per the set-up of the site
# typically if the following files are taken from ORACLE user it should do
source .bashrc
source .bash_profile
# Check if the number of params are sufficient
echo $#
if [ "$#" -ne 8 ] && [ "$#" -ne 9 ]
then
    echo "Error in $0 - Invalid Argument Count"
    echo "Syntax: $0 oracle_user oracle_password oracle_database db_file_name db_server_ip store_id apps_server_dir from_date date_tag"
    exit
fi
echo Parameters passed:
echo ------------------
echo ""
oracle_user=$1
echo oracle_user=$oracle_user
oracle_password=$2
echo oracle_password=$oracle_password
oracle_database=$3
echo oracle_database=$oracle_database
db_file_name=$4
echo db_file_name=$db_file_name
db_server_ip=$5
echo db_server_ip=$db_server_ip
store_id=$6
echo store_id=$store_id
apps_server_dir=$7
echo apps_server_dir=$apps_server_dir
from_date=$8
echo from_date=$from_date
echo date_tag=$9
date_tag=$9
sv_file_name=$db_file_name
db_file_name=$db_file_name$9
echo ------------------
echo Invoking SQL*Plus
echo ------------------
# Following command invokes SQL*PLUS
# It is assumed that sqlplus is on path
echo sqlplus $oracle_user/$oracle_password@$oracle_database ../files/prod/database/arts_oracle/@item_download.sql $db_file_name $store_id $from_date
sqlplus $oracle_user/$oracle_password@$oracle_database @../files/prod/database/arts_oracle/item_download.sql $db_file_name $store_id $from_date
if [ "$?" -ne 0 ]
then
    # SQL*Plus command has failed
    echo "SQL*Plus command failed"
    exit "$?"
fi
echo ------------------
echo ""
echo ------------------
echo ------------------
echo Invoking FTP
echo ------------------
echo ------------------
echo ------------------
# Push the current directory and download the file from DB Server
pushd $apps_server_dir
echo wget --passive-ftp ftp://$db_server_ip/$db_file_name
wget --passive-ftp ftp://$db_server_ip/$db_file_name
if [ "$?" -ne 0 ]
then
    # FTP Failed
    echo "FTP has failed"
    exit "$?"
fi
# Popout the directory and continue
popd
echo ""
echo ------------------
echo ------------------
echo ""
echo ------------------
echo ------------------
echo Invoking ZIP
echo ------------------
# Zip-up the downloaded file
echo zip $apps_server_dir/$db_file_name  $apps_server_dir/$db_file_name
mv $apps_server_dir/$db_file_name $apps_server_dir/$sv_file_name
zip $apps_server_dir/$sv_file_name  $apps_server_dir/$sv_file_name
echo -----------------------------------------------
echo Invoking SQL*Plus to delete file from db_server
echo -----------------------------------------------
echo sqlplus $oracle_user/$oracle_password@$oracle_database delete_item_downloaded_file.sql $db_file_name
sqlplus $oracle_user/$oracle_password@$oracle_database @../files/prod/database/arts_oracle/delete_item_downloaded_file.sql $db_file_name
if [ "$?" -ne 0 ]
then
    # SQL*Plus command has failed
    echo "SQL*Plus command to delete file failed"
    exit "$?"
fi
echo ------------------
echo ""
exit 0
