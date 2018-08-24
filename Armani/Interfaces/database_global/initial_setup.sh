echo Syntax: initial_setup.bat oracle_external_username oracle_external_password oracle_external_DB
sqlplus $1/$2@$3 @set_up_lookups.sql
