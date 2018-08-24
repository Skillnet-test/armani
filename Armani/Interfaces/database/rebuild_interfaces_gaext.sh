echo Syntax: rebuild_interfaces_gaext.sh oracle_external_username oracle_external_password oracle_external_DB oracle_username oracle_password oracle_DB 
sqlplus /nolog <<-END
		set timing on
		connect $1/$2@$3;
		WHENEVER SQLERROR CONTINUE;
		@create_ext_gatbl.sql $1 $4
END
sqlplus /nolog <<-END
		set timing on
		connect $4/$5@$6;
		WHENEVER SQLERROR EXIT FAILURE;
		@create_ga_pkg.sql
END



