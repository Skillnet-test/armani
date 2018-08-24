echo Syntax: initial_setup.bat oracle_username oracle_password oracle_DB
sqlplus %1/%2@%3 @set_up_lookups.sql
