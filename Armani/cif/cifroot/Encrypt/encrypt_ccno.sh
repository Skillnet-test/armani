#!/bin/bash
# Script to install the database patch.

clear
echo " Starting 'Credit Card #' encryption."
echo ""
echo "-------------------------------------------------------------------"

java -classpath .:../../library/classes12.jar:../../library/armanirpos.jar:../../library/encrypt_util.jar:../../library/retek_platform.jar: com.armani.dbutil.CCNoEncryptor >> encrypt_util.log 2>&1

echo ""
echo "--[End]------------------------------------------------------------"



