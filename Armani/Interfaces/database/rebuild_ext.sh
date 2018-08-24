echo Syntax: initial_setup.bat oracle_username oracle_password oracle_DB
sqlplus $1/$2@$3 @rebuild_ext.sql
sqlplus $4/$5@$6 @create_pkg.sql
