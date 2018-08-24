echo Syntax: rebuild_interfaces_delta_1.5.0.2.sh oracle_external_username oracle_external_password oracle_external_DB oracle_username oracle_password oracle_DB 
sqlplus /nolog <<-END
        set timing on
        connect $4/$5@$6;
        WHENEVER SQLERROR EXIT FAILURE;
        @create_item_pkg_delta_eur_3.0.0.0.sql
END




