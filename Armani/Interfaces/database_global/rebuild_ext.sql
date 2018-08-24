define core_user = &2
define ext_user = &1
@create_ext_tables.sql
@drop_ext_table_synonym.sql &ext_user &core_user
@create_ext_table_synonym.sql &ext_user &core_user
@grant_to_ext_tables.sql &core_user
@create_ext_pkg.sql