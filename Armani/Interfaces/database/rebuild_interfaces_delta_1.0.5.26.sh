echo Syntax: rebuild_interfaces_delta_1.0.5.08.sh oracle_external_username oracle_external_password oracle_external_DB oracle_username oracle_password oracle_DB 
sqlplus /nolog <<-END
        set timing on
        connect $4/$5@$6;
        WHENEVER SQLERROR EXIT FAILURE;
        @create_cust_pkg_delta_1.0.5.26.sql
END




