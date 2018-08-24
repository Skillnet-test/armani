echo Syntax: rebuild_interfaces_delta_1.0.5.12.sh oracle_external_username oracle_external_password oracle_external_DB oracle_username oracle_password oracle_DB 
sqlplus /nolog <<-END
        set timing on
        connect $1/$2@$3;
        WHENEVER SQLERROR EXIT FAILURE;
        @alter_stg_table_1.0.5.12.sql
END
sqlplus /nolog <<-END
        set timing on
        connect $4/$5@$6;
        WHENEVER SQLERROR EXIT FAILURE;
        @alter_core_delta_1.0.5.12.sql
END




