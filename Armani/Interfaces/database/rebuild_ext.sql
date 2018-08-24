define core_user = &2
define ext_user = &1
@create_stg_tables.sql
@create_stg_tables_europe.sql
@create_synonym.sql &ext_user
@create_synonym_europe.sql &ext_user
@grant_to_stg_tables.sql &core_user
@grant_to_stg_tables_europe.sql &core_user
@create_ext_pkg.sql



